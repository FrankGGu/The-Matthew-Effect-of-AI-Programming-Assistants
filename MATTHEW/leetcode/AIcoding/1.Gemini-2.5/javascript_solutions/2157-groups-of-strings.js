class DSU {
    constructor() {
        this.parent = new Map(); // mask -> parent_mask
        this.groupSize = new Map(); // mask -> size_of_group (stores sum of counts of original words in this group)
        this.numGroups = 0;
        this.maxGroupSize = 0;
    }

    find(i) {
        if (!this.parent.has(i)) {
            return i; 
        }
        if (this.parent.get(i) === i) {
            return i;
        }
        const root = this.find(this.parent.get(i));
        this.parent.set(i, root);
        return root;
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            if (this.groupSize.get(rootI) < this.groupSize.get(rootJ)) {
                [rootI, rootJ] = [rootJ, rootI]; 
            }
            this.parent.set(rootJ, rootI);
            this.groupSize.set(rootI, this.groupSize.get(rootI) + this.groupSize.get(rootJ));
            this.numGroups--;
            this.maxGroupSize = Math.max(this.maxGroupSize, this.groupSize.get(rootI));
            return true;
        }
        return false;
    }

    addMask(mask, initialCount = 1) {
        if (!this.parent.has(mask)) {
            this.parent.set(mask, mask);
            this.groupSize.set(mask, initialCount);
            this.numGroups++;
            this.maxGroupSize = Math.max(this.maxGroupSize, initialCount);
            return true;
        } else {
            const root = this.find(mask);
            this.groupSize.set(root, this.groupSize.get(root) + initialCount);
            this.maxGroupSize = Math.max(this.maxGroupSize, this.groupSize.get(root));
            return false;
        }
    }
}

function groupsOfStrings(words) {
    const dsu = new DSU();
    const maskCounts = new Map();

    for (const word of words) {
        let mask = 0;
        for (let i = 0; i < word.length; i++) {
            mask |= (1 << (word.charCodeAt(i) - 'a'.charCodeAt(0)));
        }
        maskCounts.set(mask, (maskCounts.get(mask) || 0) + 1);
    }

    for (const [mask, count] of maskCounts.entries()) {
        dsu.addMask(mask, count);
    }

    for (const [mask, count] of maskCounts.entries()) {
        // Rule 1: One-bit difference (add/delete character)
        for (let i = 0; i < 26; i++) {
            const neighborMask = mask ^ (1 << i);
            if (maskCounts.has(neighborMask)) {
                dsu.union(mask, neighborMask);
            }
        }

        // Rule 2: Two-bit difference (replace character)
        // This means deleting one character (bit i) and adding another (bit j).
        for (let i = 0; i < 26; i++) {
            if (!((mask >> i) & 1)) continue; // Bit i must be set in original mask (character to delete)

            const maskAfterDelete = mask ^ (1 << i);

            for (let j = 0; j < 26; j++) {
                if (((maskAfterDelete >> j) & 1)) continue; // Bit j must be unset in maskAfterDelete (character to add)

                const neighborMask = maskAfterDelete | (1 << j); 

                if (maskCounts.has(neighborMask)) {
                    dsu.union(mask, neighborMask);
                }
            }
        }
    }

    return [dsu.numGroups, dsu.maxGroupSize];
}
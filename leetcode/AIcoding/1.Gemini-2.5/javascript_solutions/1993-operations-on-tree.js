class LockingTree {
    constructor(parent) {
        this.parent = parent;
        this.n = parent.length;
        this.children = new Array(this.n).fill(0).map(() => []);
        this.lockedBy = new Array(this.n).fill(0); // 0 means unlocked, positive integer is userId

        for (let i = 1; i < this.n; i++) {
            this.children[parent[i]].push(i);
        }
    }

    lock(num, user) {
        if (this.lockedBy[num] === 0) {
            this.lockedBy[num] = user;
            return true;
        }
        return false;
    }

    unlock(num, user) {
        if (this.lockedBy[num] === user) {
            this.lockedBy[num] = 0;
            return true;
        }
        return false;
    }

    upgrade(num, user) {
        // Condition 1: Node num is unlocked
        if (this.lockedBy[num] !== 0) {
            return false;
        }

        // Condition 3: None of its ancestors are locked
        let currAncestor = this.parent[num];
        while (currAncestor !== -1) {
            if (this.lockedBy[currAncestor] !== 0) {
                return false;
            }
            currAncestor = this.parent[currAncestor];
        }

        // Condition 2: At least one of its descendants is locked
        let hasLockedDescendant = false;
        const nodesToUnlock = [];
        const queue = [...this.children[num]]; // Start BFS from direct children

        while (queue.length > 0) {
            const node = queue.shift();

            if (this.lockedBy[node] !== 0) {
                hasLockedDescendant = true;
                nodesToUnlock.push(node);
            }

            for (const child of this.children[node]) {
                queue.push(child);
            }
        }

        if (!hasLockedDescendant) {
            return false;
        }

        // All conditions met, perform upgrade
        this.lockedBy[num] = user;
        for (const node of nodesToUnlock) {
            this.lockedBy[node] = 0;
        }

        return true;
    }
}
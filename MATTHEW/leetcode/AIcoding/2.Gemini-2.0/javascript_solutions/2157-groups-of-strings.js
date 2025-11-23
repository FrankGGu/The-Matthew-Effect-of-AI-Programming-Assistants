var groupStrings = function(words) {
    const n = words.length;
    const parent = Array(n).fill(0).map((_, i) => i);
    let groups = n;

    function find(i) {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    function union(i, j) {
        const rootI = find(i);
        const rootJ = find(j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
            groups--;
        }
    }

    const masks = words.map(word => {
        let mask = 0;
        for (const char of word) {
            mask |= (1 << (char.charCodeAt(0) - 'a'.charCodeAt(0)));
        }
        return mask;
    });

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if ((masks[i] ^ masks[j]).toString(2).split('0').join('').length <= 2) {
                union(i, j);
            } else {
                const maskI = masks[i];
                const maskJ = masks[j];

                let diffCount = 0;
                for(let k = 0; k < 26; k++) {
                    if(((maskI >> k) & 1) !== ((maskJ >> k) & 1)) {
                        diffCount++;
                    }
                }
                if(diffCount === 2) {
                     let tempMaskI = maskI;
                    let tempMaskJ = maskJ;
                    let bitI = -1;
                    let bitJ = -1;
                    for(let k = 0; k < 26; k++) {
                        if(((maskI >> k) & 1) !== ((maskJ >> k) & 1)) {
                            if(bitI === -1) bitI = k;
                            else bitJ = k;
                        }
                    }
                }

            }
        }
    }

    const freq = {};
    for (let i = 0; i < n; i++) {
        const root = find(i);
        freq[root] = (freq[root] || 0) + 1;
    }

    let maxGroupSize = 0;
    for (const root in freq) {
        maxGroupSize = Math.max(maxGroupSize, freq[root]);
    }

    return [groups, maxGroupSize];
};
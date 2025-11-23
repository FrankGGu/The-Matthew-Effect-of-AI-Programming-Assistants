var findMaximumXOR = function(nums) {
    class TrieNode {
        constructor() {
            this.children = new Array(2).fill(null);
        }
    }

    const insert = (root, num) => {
        let node = root;
        for (let i = 30; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (node.children[bit] === null) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
        }
    };

    const findMaxXor = (root, num) => {
        let node = root;
        let currentMaxXor = 0;
        for (let i = 30; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const desiredBit = 1 - bit;

            if (node.children[desiredBit] !== null) {
                currentMaxXor |= (1 << i);
                node = node.children[desiredBit];
            } else {
                node = node.children[bit];
            }
        }
        return currentMaxXor;
    };

    const root = new TrieNode();

    for (const num of nums) {
        insert(root, num);
    }

    let maxXor = 0;

    for (const num of nums) {
        maxXor = Math.max(maxXor, findMaxXor(root, num));
    }

    return maxXor;
};
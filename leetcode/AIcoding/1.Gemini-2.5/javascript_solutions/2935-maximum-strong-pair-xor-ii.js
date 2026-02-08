class TrieNode {
    constructor() {
        this.children = new Array(2).fill(null);
        this.count = 0;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
        this.MAX_BITS = 18; 
    }

    insert(num) {
        let node = this.root;
        for (let i = this.MAX_BITS - 1; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!node.children[bit]) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
            node.count++;
        }
    }

    remove(num) {
        let node = this.root;
        for (let i = this.MAX_BITS - 1; i >= 0; i--) {
            const bit = (num >> i) & 1;
            node = node.children[bit];
            node.count--;
        }
    }

    getMaxXor(num) {
        let node = this.root;
        let currentXor = 0;
        for (let i = this.MAX_BITS - 1; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const oppositeBit = 1 - bit;

            if (node.children[oppositeBit] && node.children[oppositeBit].count > 0) {
                currentXor = (currentXor << 1) | 1;
                node = node.children[oppositeBit];
            } 
            else if (node.children[bit] && node.children[bit].count > 0) {
                currentXor = (currentXor << 1) | 0;
                node = node.children[bit];
            } 
            else {
                break; 
            }
        }
        return currentXor;
    }
}

var maximumStrongPairXor = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const trie = new Trie();
    let maxXor = 0;
    let left = 0; 

    for (let i = 0; i < n; i++) {
        const x = nums[i];

        while (left < i && nums[left] < x / 2) {
            trie.remove(nums[left]);
            left++;
        }

        trie.insert(x);

        maxXor = Math.max(maxXor, trie.getMaxXor(x));
    }

    return maxXor;
};
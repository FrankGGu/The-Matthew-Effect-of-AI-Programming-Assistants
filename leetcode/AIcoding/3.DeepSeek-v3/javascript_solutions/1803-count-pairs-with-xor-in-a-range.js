class TrieNode {
    constructor() {
        this.children = new Array(2).fill(null);
        this.count = 0;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(num) {
        let node = this.root;
        for (let i = 14; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (node.children[bit] === null) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
            node.count++;
        }
    }

    query(num, limit) {
        let node = this.root;
        let res = 0;
        for (let i = 14; i >= 0 && node !== null; i--) {
            const bitNum = (num >> i) & 1;
            const bitLimit = (limit >> i) & 1;
            if (bitLimit === 1) {
                if (node.children[bitNum] !== null) {
                    res += node.children[bitNum].count;
                }
                node = node.children[1 - bitNum];
            } else {
                node = node.children[bitNum];
            }
        }
        return res;
    }
}

var countPairs = function(nums, low, high) {
    const trie = new Trie();
    let res = 0;
    for (const num of nums) {
        res += trie.query(num, high + 1) - trie.query(num, low);
        trie.insert(num);
    }
    return res;
};
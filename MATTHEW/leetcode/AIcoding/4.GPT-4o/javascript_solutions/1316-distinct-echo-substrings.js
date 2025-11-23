class TrieNode {
    constructor() {
        this.children = new Map();
        this.count = 0;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(word) {
        let node = this.root;
        for (let char of word) {
            if (!node.children.has(char)) {
                node.children.set(char, new TrieNode());
            }
            node = node.children.get(char);
            node.count++;
        }
    }
}

var distinctEchoSubstrings = function(text) {
    const trie = new Trie();
    const seen = new Set();
    let result = 0;

    for (let length = 1; length <= text.length; length++) {
        for (let start = 0; start + length <= text.length; start++) {
            const substring = text.substring(start, start + length);
            if (!seen.has(substring)) {
                seen.add(substring);
                trie.insert(substring);
                let node = trie.root;
                let j = start;
                while (j < text.length && node) {
                    node = node.children.get(text[j]);
                    if (node) {
                        if (node.count > 1) {
                            result++;
                        }
                    }
                    j++;
                }
            }
        }
    }

    return result;
};
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

    countPrefixScores(word) {
        let node = this.root;
        let score = 0;
        for (let char of word) {
            if (node.children.has(char)) {
                node = node.children.get(char);
                score += node.count;
            }
        }
        return score;
    }
}

var sumPrefixScores = function(words) {
    const trie = new Trie();
    for (let word of words) {
        trie.insert(word);
    }
    return words.map(word => trie.countPrefixScores(word));
};
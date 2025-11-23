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
        for (const char of word) {
            if (!node.children.has(char)) {
                node.children.set(char, new TrieNode());
            }
            node = node.children.get(char);
            node.count++;
        }
    }

    getScore(word) {
        let node = this.root;
        let score = 0;
        for (const char of word) {
            node = node.children.get(char);
            score += node.count;
        }
        return score;
    }
}

var sumPrefixScores = function(words) {
    const trie = new Trie();

    for (const word of words) {
        trie.insert(word);
    }

    const scores = [];
    for (const word of words) {
        scores.push(trie.getScore(word));
    }

    return scores;
};
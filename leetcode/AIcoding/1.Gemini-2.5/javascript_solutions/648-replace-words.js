class TrieNode {
    constructor() {
        this.children = new Map();
        this.isEndOfWord = false;
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
        }
        node.isEndOfWord = true;
    }

    searchShortestRoot(word) {
        let node = this.root;
        let currentPrefix = "";
        for (const char of word) {
            if (!node.children.has(char)) {
                return word;
            }
            node = node.children.get(char);
            currentPrefix += char;
            if (node.isEndOfWord) {
                return currentPrefix;
            }
        }
        return word;
    }
}

var replaceWords = function(dictionary, sentence) {
    const trie = new Trie();
    for (const root of dictionary) {
        trie.insert(root);
    }

    const words = sentence.split(' ');
    const resultWords = [];

    for (const word of words) {
        resultWords.push(trie.searchShortestRoot(word));
    }

    return resultWords.join(' ');
};
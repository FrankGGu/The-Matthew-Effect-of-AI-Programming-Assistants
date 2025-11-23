class TrieNode {
    constructor() {
        this.children = new Map();
        this.isEndOfWord = false;
    }
}

class WordDictionary {
    constructor() {
        this.root = new TrieNode();
    }

    addWord(word) {
        let node = this.root;
        for (const char of word) {
            if (!node.children.has(char)) {
                node.children.set(char, new TrieNode());
            }
            node = node.children.get(char);
        }
        node.isEndOfWord = true;
    }

    search(word) {
        return this.searchInNode(word, this.root);
    }

    searchInNode(word, node) {
        for (let i = 0; i < word.length; i++) {
            const char = word[i];
            if (char === '.') {
                for (const child of node.children.values()) {
                    if (this.searchInNode(word.slice(i + 1), child)) {
                        return true;
                    }
                }
                return false;
            } else {
                if (!node.children.has(char)) {
                    return false;
                }
                node = node.children.get(char);
            }
        }
        return node.isEndOfWord;
    }
}
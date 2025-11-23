class TrieNode {
    constructor() {
        this.children = {};
        this.isWord = false;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(word) {
        let node = this.root;
        for (let i = word.length - 1; i >= 0; i--) {
            const char = word[i];
            if (!node.children[char]) {
                node.children[char] = new TrieNode();
            }
            node = node.children[char];
        }
        node.isWord = true;
    }
}

class StreamChecker {
    constructor(words) {
        this.trie = new Trie();
        for (const word of words) {
            this.trie.insert(word);
        }
        this.stream = [];
    }

    query(letter) {
        this.stream.push(letter);
        let node = this.trie.root;
        for (let i = this.stream.length - 1; i >= 0; i--) {
            const char = this.stream[i];
            if (!node.children[char]) {
                return false;
            }
            node = node.children[char];
            if (node.isWord) {
                return true;
            }
        }
        return false;
    }
}
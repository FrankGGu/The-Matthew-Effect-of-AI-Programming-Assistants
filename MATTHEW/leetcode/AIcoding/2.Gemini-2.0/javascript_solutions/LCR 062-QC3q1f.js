class Trie {
    constructor() {
        this.children = {};
        this.isWord = false;
    }

    insert(word) {
        let node = this;
        for (let char of word) {
            if (!node.children[char]) {
                node.children[char] = new Trie();
            }
            node = node.children[char];
        }
        node.isWord = true;
    }

    search(word) {
        let node = this;
        for (let char of word) {
            if (!node.children[char]) {
                return false;
            }
            node = node.children[char];
        }
        return node.isWord;
    }

    startsWith(prefix) {
        let node = this;
        for (let char of prefix) {
            if (!node.children[char]) {
                return false;
            }
            node = node.children[char];
        }
        return true;
    }
}
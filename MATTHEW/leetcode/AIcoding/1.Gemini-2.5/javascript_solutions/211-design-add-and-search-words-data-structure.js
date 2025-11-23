class TrieNode {
    constructor() {
        this.children = {};
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
            if (!node.children[char]) {
                node.children[char] = new TrieNode();
            }
            node = node.children[char];
        }
        node.isEndOfWord = true;
    }

    search(word) {
        return this._search(word, this.root, 0);
    }

    _search(word, node, index) {
        if (index === word.length) {
            return node.isEndOfWord;
        }

        const char = word[index];

        if (char === '.') {
            for (const childChar in node.children) {
                if (this._search(word, node.children[childChar], index + 1)) {
                    return true;
                }
            }
            return false;
        } else {
            if (!node.children[char]) {
                return false;
            }
            return this._search(word, node.children[char], index + 1);
        }
    }
}
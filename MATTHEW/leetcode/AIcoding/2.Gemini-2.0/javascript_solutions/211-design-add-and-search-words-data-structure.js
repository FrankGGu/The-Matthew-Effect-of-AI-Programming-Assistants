class TrieNode {
    constructor() {
        this.children = {};
        this.isWord = false;
    }
}

class WordDictionary {
    constructor() {
        this.root = new TrieNode();
    }

    addWord(word) {
        let node = this.root;
        for (let char of word) {
            if (!node.children[char]) {
                node.children[char] = new TrieNode();
            }
            node = node.children[char];
        }
        node.isWord = true;
    }

    search(word) {
        function searchHelper(node, word, index) {
            if (index === word.length) {
                return node.isWord;
            }

            const char = word[index];

            if (char === '.') {
                for (let nextChar in node.children) {
                    if (searchHelper(node.children[nextChar], word, index + 1)) {
                        return true;
                    }
                }
                return false;
            } else {
                if (!node.children[char]) {
                    return false;
                }
                return searchHelper(node.children[char], word, index + 1);
            }
        }

        return searchHelper(this.root, word, 0);
    }
}
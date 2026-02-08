class TrieNode {
    constructor() {
        this.children = {};
        this.isEnd = false;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(word) {
        let node = this.root;
        for (const char of word) {
            if (!node.children[char]) {
                node.children[char] = new TrieNode();
            }
            node = node.children[char];
        }
        node.isEnd = true;
    }

    searchPrefix(word) {
        let node = this.root;
        let prefix = '';
        for (const char of word) {
            if (node.children[char]) {
                prefix += char;
                node = node.children[char];
                if (node.isEnd) {
                    return prefix;
                }
            } else {
                break;
            }
        }
        return word;
    }
}

var replaceWords = function(dict, sentence) {
    const trie = new Trie();
    for (const root of dict) {
        trie.insert(root);
    }

    return sentence.split(' ').map(word => trie.searchPrefix(word)).join(' ');
};
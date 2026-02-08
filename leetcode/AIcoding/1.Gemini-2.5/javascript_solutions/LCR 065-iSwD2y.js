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
        for (let i = word.length - 1; i >= 0; i--) {
            const char = word[i];
            if (!node.children.has(char)) {
                node.children.set(char, new TrieNode());
            }
            node = node.children.get(char);
        }
        node.isEndOfWord = true;
    }
}

var minimumLengthEncoding = function(words) {
    const uniqueWords = new Set(words);
    const trie = new Trie();

    for (const word of uniqueWords) {
        trie.insert(word);
    }

    let totalLength = 0;

    function dfs(node, currentDepth) {
        let isLeafNode = true;

        for (const childNode of node.children.values()) {
            isLeafNode = false;
            dfs(childNode, currentDepth + 1);
        }

        if (isLeafNode && node.isEndOfWord) {
            totalLength += currentDepth + 1;
        }
    }

    dfs(trie.root, 0);

    return totalLength;
};
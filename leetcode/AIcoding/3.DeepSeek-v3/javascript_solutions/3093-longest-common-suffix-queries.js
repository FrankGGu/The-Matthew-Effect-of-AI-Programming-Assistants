var stringIndices = function(wordsContainer, wordsQuery) {
    const trie = new Trie();
    for (let i = 0; i < wordsContainer.length; i++) {
        const word = wordsContainer[i];
        trie.insert(word.split('').reverse().join(''), i);
    }

    const result = [];
    for (const query of wordsQuery) {
        const reversedQuery = query.split('').reverse().join('');
        const index = trie.search(reversedQuery);
        result.push(index);
    }
    return result;
};

class TrieNode {
    constructor() {
        this.children = {};
        this.index = -1;
        this.minLength = Infinity;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(word, index) {
        let node = this.root;
        if (node.minLength > word.length) {
            node.minLength = word.length;
            node.index = index;
        }
        for (const char of word) {
            if (!node.children[char]) {
                node.children[char] = new TrieNode();
            }
            node = node.children[char];
            if (node.minLength > word.length) {
                node.minLength = word.length;
                node.index = index;
            }
        }
    }

    search(word) {
        let node = this.root;
        for (const char of word) {
            if (!node.children[char]) {
                break;
            }
            node = node.children[char];
        }
        return node.index;
    }
}
class TrieNode {
    constructor() {
        this.children = new Map();
        this.minIdx = Infinity; // Stores the minimum original index of a word that passes through this node
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(word, originalIndex) {
        let curr = this.root;
        const reversedWord = word.split('').reverse().join('');

        for (const char of reversedWord) {
            if (!curr.children.has(char)) {
                curr.children.set(char, new TrieNode());
            }
            curr = curr.children.get(char);
            // Update minIdx for the current node with the smallest original index encountered so far
            curr.minIdx = Math.min(curr.minIdx, originalIndex);
        }
    }

    query(queryString) {
        let curr = this.root;
        const reversedQuery = queryString.split('').reverse().join('');

        for (const char of reversedQuery) {
            if (!curr.children.has(char)) {
                return -1; // No word in the dictionary has this query as a suffix
            }
            curr = curr.children.get(char);
        }

        // After traversing the entire reversed query, 'curr' points to the node
        // that represents the end of the reversed query (i.e., the start of the original query).
        // The minIdx at this node stores the smallest original index of any word
        // that has this reversed query as a prefix (which means the original query is a suffix).
        return curr.minIdx === Infinity ? -1 : curr.minIdx;
    }
}

var longestCommonSuffixQueries = function(words, queries) {
    const trie = new Trie();

    for (let i = 0; i < words.length; i++) {
        trie.insert(words[i], i);
    }

    const results = [];
    for (const q of queries) {
        results.push(trie.query(q));
    }

    return results;
};
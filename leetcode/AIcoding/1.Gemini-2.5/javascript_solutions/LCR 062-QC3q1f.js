var TrieNode = function() {
    this.children = {};
    this.isEndOfWord = false;
};

var Trie = function() {
    this.root = new TrieNode();
};

Trie.prototype.insert = function(word) {
    let curr = this.root;
    for (let i = 0; i < word.length; i++) {
        const char = word[i];
        if (!(char in curr.children)) {
            curr.children[char] = new TrieNode();
        }
        curr = curr.children[char];
    }
    curr.isEndOfWord = true;
};

Trie.prototype.search = function(word) {
    let curr = this.root;
    for (let i = 0; i < word.length; i++) {
        const char = word[i];
        if (!(char in curr.children)) {
            return false;
        }
        curr = curr.children[char];
    }
    return curr.isEndOfWord;
};

Trie.prototype.startsWith = function(prefix) {
    let curr = this.root;
    for (let i = 0; i < prefix.length; i++) {
        const char = prefix[i];
        if (!(char in curr.children)) {
            return false;
        }
        curr = curr.children[char];
    }
    return true;
};
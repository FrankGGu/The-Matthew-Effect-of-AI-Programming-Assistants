var StreamChecker = function(words) {
    this.trie = {};
    this.stream = [];
    for (const word of words) {
        let node = this.trie;
        for (let i = word.length - 1; i >= 0; i--) {
            const char = word[i];
            if (!node[char]) node[char] = {};
            node = node[char];
        }
        node.isEnd = true;
    }
};

StreamChecker.prototype.query = function(letter) {
    this.stream.unshift(letter);
    let node = this.trie;
    for (const char of this.stream) {
        if (node.isEnd) return true;
        if (!node[char]) return false;
        node = node[char];
    }
    return node.isEnd === true;
};
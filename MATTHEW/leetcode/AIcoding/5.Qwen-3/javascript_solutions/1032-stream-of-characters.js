var StreamChecker = function (letters) {
    this.letters = letters;
    this.n = letters.length;
    this.trie = {};
    this.maxLen = 0;
    this.queue = [];
};

StreamChecker.prototype.insert = function (word) {
    let node = this.trie;
    for (let c of word) {
        if (!node[c]) node[c] = {};
        node = node[c];
    }
    node.isEnd = true;
};

StreamChecker.prototype.query = function (c) {
    this.queue.push(c);
    if (this.queue.length > this.maxLen) this.queue.shift();
    let node = this.trie;
    for (let i = this.queue.length - 1; i >= 0; i--) {
        let char = this.queue[i];
        if (!node[char]) return false;
        node = node[char];
        if (node.isEnd) return true;
    }
    return false;
};

StreamChecker.prototype.addWord = function (word) {
    this.insert(word);
    this.maxLen = Math.max(this.maxLen, word.length);
};
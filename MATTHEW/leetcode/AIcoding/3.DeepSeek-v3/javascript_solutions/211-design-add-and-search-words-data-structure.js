var WordDictionary = function() {
    this.root = {};
};

WordDictionary.prototype.addWord = function(word) {
    let node = this.root;
    for (const char of word) {
        if (!node[char]) node[char] = {};
        node = node[char];
    }
    node.isEnd = true;
};

WordDictionary.prototype.search = function(word) {
    return this.searchInNode(word, this.root);
};

WordDictionary.prototype.searchInNode = function(word, node) {
    for (let i = 0; i < word.length; i++) {
        const char = word[i];
        if (char === '.') {
            for (const key in node) {
                if (key === 'isEnd') continue;
                if (this.searchInNode(word.slice(i + 1), node[key])) {
                    return true;
                }
            }
            return false;
        } else {
            if (!node[char]) return false;
            node = node[char];
        }
    }
    return node.isEnd === true;
};
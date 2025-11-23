var WordFilter = function(words) {
    this.trie = {};
    for (let weight = 0; weight < words.length; weight++) {
        const word = words[weight];
        const len = word.length;
        for (let i = 0; i <= len; i++) {
            for (let j = 0; j <= len; j++) {
                const key = word.substring(0, i) + '#' + word.substring(len - j);
                this.trie[key] = weight;
            }
        }
    }
};

WordFilter.prototype.f = function(prefix, suffix) {
    const key = prefix + '#' + suffix;
    return this.trie[key] !== undefined ? this.trie[key] : -1;
};
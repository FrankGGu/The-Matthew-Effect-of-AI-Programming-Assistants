var PrefixSuffixSearch = function(words) {
    this.map = {};
    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        for (let j = 0; j < word.length; j++) {
            for (let k = word.length - 1; k >= j; k--) {
                const prefix = word.substring(0, j + 1);
                const suffix = word.substring(k);
                this.map[prefix + ',' + suffix] = i;
            }
        }
    }
};

PrefixSuffixSearch.prototype.search = function(prefix, suffix) {
    return this.map[prefix + ',' + suffix] || -1;
};
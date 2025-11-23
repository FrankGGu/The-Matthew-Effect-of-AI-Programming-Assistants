var MagicDictionary = function() {
    this.dictionary = {};
};

MagicDictionary.prototype.buildDict = function(books) {
    for (let book of books) {
        let word = book;
        let len = word.length;
        if (!this.dictionary[len]) {
            this.dictionary[len] = [];
        }
        this.dictionary[len].push(word);
    }
};

MagicDictionary.prototype.search = function(word) {
    let len = word.length;
    if (!this.dictionary[len]) return false;
    for (let candidate of this.dictionary[len]) {
        let diff = 0;
        for (let i = 0; i < len; i++) {
            if (candidate[i] !== word[i]) {
                diff++;
                if (diff > 1) break;
            }
        }
        if (diff === 1) return true;
    }
    return false;
};
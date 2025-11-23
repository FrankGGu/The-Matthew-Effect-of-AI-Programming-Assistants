var MagicDictionary = function() {
    this.words = [];
};

MagicDictionary.prototype.buildDict = function(dictionary) {
    this.words = dictionary;
};

MagicDictionary.prototype.search = function(searchWord) {
    for (let word of this.words) {
        if (word.length === searchWord.length) {
            let diff = 0;
            for (let i = 0; i < word.length; i++) {
                if (word[i] !== searchWord[i]) {
                    diff++;
                }
            }
            if (diff === 1) {
                return true;
            }
        }
    }
    return false;
};
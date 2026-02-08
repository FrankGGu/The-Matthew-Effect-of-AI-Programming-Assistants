var MagicDictionary = function() {
    this.dict = [];
};

MagicDictionary.prototype.buildDict = function(dictionary) {
    this.dict = dictionary;
};

MagicDictionary.prototype.search = function(searchWord) {
    for (const word of this.dict) {
        if (word.length !== searchWord.length) continue;
        let diff = 0;
        for (let i = 0; i < word.length; i++) {
            if (word[i] !== searchWord[i]) diff++;
            if (diff > 1) break;
        }
        if (diff === 1) return true;
    }
    return false;
};
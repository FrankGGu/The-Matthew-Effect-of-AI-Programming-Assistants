var MagicDictionary = function() {
    this.dict = [];
};

MagicDictionary.prototype.buildDict = function(dictionary) {
    this.dict = dictionary;
};

MagicDictionary.prototype.search = function(searchWord) {
    for (const dictWord of this.dict) {
        if (dictWord.length !== searchWord.length) {
            continue;
        }

        let diffCount = 0;
        for (let i = 0; i < dictWord.length; i++) {
            if (dictWord[i] !== searchWord[i]) {
                diffCount++;
            }
        }

        if (diffCount === 1) {
            return true;
        }
    }
    return false;
};
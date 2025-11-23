var MagicDictionary = function() {
    this.wordMap = new Map();
};

MagicDictionary.prototype.buildDict = function(dictionary) {
    for (const word of dictionary) {
        if (!this.wordMap.has(word.length)) {
            this.wordMap.set(word.length, []);
        }
        this.wordMap.get(word.length).push(word);
    }
};

MagicDictionary.prototype.search = function(searchWord) {
    const len = searchWord.length;
    if (!this.wordMap.has(len)) {
        return false;
    }

    const candidateWords = this.wordMap.get(len);

    for (const dictWord of candidateWords) {
        let diffCount = 0;
        for (let i = 0; i < len; i++) {
            if (searchWord[i] !== dictWord[i]) {
                diffCount++;
            }
            if (diffCount > 1) {
                break;
            }
        }
        if (diffCount === 1) {
            return true;
        }
    }

    return false;
};
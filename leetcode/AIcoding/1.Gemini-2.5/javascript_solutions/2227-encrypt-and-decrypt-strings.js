var Encrypter = function(keys, values, dictionary) {
    this.keyToValMap = new Map();
    for (let i = 0; i < keys.length; i++) {
        this.keyToValMap.set(keys[i], values[i]);
    }

    this.encryptedDictionaryCounts = new Map();
    for (const dictWord of dictionary) {
        let encryptedWord = "";
        let possible = true;
        for (const char of dictWord) {
            if (this.keyToValMap.has(char)) {
                encryptedWord += this.keyToValMap.get(char);
            } else {
                possible = false;
                break;
            }
        }
        if (possible) {
            this.encryptedDictionaryCounts.set(encryptedWord, (this.encryptedDictionaryCounts.get(encryptedWord) || 0) + 1);
        }
    }
};

Encrypter.prototype.encrypt = function(word1) {
    let result = "";
    for (const char of word1) {
        if (this.keyToValMap.has(char)) {
            result += this.keyToValMap.get(char);
        } else {
            // According to problem constraints, all characters in word1 will be in keys.
            // If not, an empty string or error might be returned. For this problem,
            // we assume valid input characters.
            return ""; 
        }
    }
    return result;
};

Encrypter.prototype.decrypt = function(word2) {
    return this.encryptedDictionaryCounts.get(word2) || 0;
};
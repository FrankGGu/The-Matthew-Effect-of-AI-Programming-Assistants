var Encrypter = function(keys, values, dictionary) {
    this.keyToValue = {};
    this.valueToKeys = {};
    this.dictionary = dictionary;

    for (let i = 0; i < keys.length; i++) {
        this.keyToValue[keys[i]] = values[i];
        if (!this.valueToKeys[values[i]]) {
            this.valueToKeys[values[i]] = [];
        }
        this.valueToKeys[values[i]].push(keys[i]);
    }
};

Encrypter.prototype.encrypt = function(word1) {
    let encrypted = '';
    for (const c of word1) {
        if (this.keyToValue[c]) {
            encrypted += this.keyToValue[c];
        } else {
            return '';
        }
    }
    return encrypted;
};

Encrypter.prototype.decrypt = function(word2) {
    let count = 0;
    for (const word of this.dictionary) {
        if (this.encrypt(word) === word2) {
            count++;
        }
    }
    return count;
};
var Encrypter = function(keys, values, dictionary) {
    this.keyMap = new Map();
    this.valueMap = new Map();
    this.dictionary = new Set(dictionary);

    for (let i = 0; i < keys.length; i++) {
        this.keyMap.set(keys[i], values[i]);
        this.valueMap.set(values[i], keys[i]);
    }
};

Encrypter.prototype.encrypt = function(word1) {
    let encrypted = "";
    for (let char of word1) {
        if (this.keyMap.has(char)) {
            encrypted += this.keyMap.get(char);
        } else {
            return "";
        }
    }
    return encrypted;
};

Encrypter.prototype.decrypt = function(word2) {
    let count = 0;
    let n = word2.length;
    if (n % 2 !== 0) return 0;

    const memo = new Map();

    const solve = (index, currentWord) => {
        if (index === n) {
            if (this.dictionary.has(currentWord)) {
                return 1;
            } else {
                return 0;
            }
        }

        const key = `${index}-${currentWord}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        let res = 0;
        let pair = word2.substring(index, index + 2);

        if (this.valueMap.has(pair)) {
            res += solve(index + 2, currentWord + this.valueMap.get(pair));
        }

        memo.set(key, res);
        return res;
    };

    return solve(0, "");
};
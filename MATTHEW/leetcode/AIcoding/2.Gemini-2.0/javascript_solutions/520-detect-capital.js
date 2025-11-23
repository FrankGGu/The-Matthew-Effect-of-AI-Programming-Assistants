var detectCapitalUse = function(word) {
    if (word.length === 0) return true;
    if (word.length === 1) return true;

    if (word[0] === word[0].toUpperCase()) {
        if (word[1] === word[1].toUpperCase()) {
            for (let i = 2; i < word.length; i++) {
                if (word[i] !== word[i].toUpperCase()) return false;
            }
            return true;
        } else {
            for (let i = 2; i < word.length; i++) {
                if (word[i] !== word[i].toLowerCase()) return false;
            }
            return true;
        }
    } else {
        for (let i = 1; i < word.length; i++) {
            if (word[i] !== word[i].toLowerCase()) return false;
        }
        return true;
    }
};
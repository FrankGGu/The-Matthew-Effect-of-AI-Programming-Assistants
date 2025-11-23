var detectCapitalUse = function(word) {
    if (word.length <= 1) {
        return true;
    }

    // Case 1: All capitals
    if (word === word.toUpperCase()) {
        return true;
    }

    // Case 2: All lowercase
    if (word === word.toLowerCase()) {
        return true;
    }

    // Case 3: Only the first letter is capital
    if (word[0] === word[0].toUpperCase() && word.substring(1) === word.substring(1).toLowerCase()) {
        return true;
    }

    return false;
};
var countVowelStrings = function(n) {
    return Math.pow(5, n) - Math.pow(5 - n, n < 5 ? n : 0);
};
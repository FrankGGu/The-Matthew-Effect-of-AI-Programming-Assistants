var smallestSubstringWithIdenticalCharactersII = function(s) {
    for (let i = 0; i < s.length - 1; i++) {
        if (s[i] === s[i+1]) {
            return 2;
        }
    }
    return -1;
};
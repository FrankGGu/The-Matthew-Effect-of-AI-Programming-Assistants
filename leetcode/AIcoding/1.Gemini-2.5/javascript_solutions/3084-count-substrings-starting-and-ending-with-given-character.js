var countSubstrings = function(s, c) {
    let occurrences = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === c) {
            occurrences++;
        }
    }
    return occurrences * (occurrences + 1) / 2;
};
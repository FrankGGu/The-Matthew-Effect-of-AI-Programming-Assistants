var countSubstrings = function(s, c) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            if (s[i] === c && s[j] === c) {
                count++;
            }
        }
    }
    return count;
};
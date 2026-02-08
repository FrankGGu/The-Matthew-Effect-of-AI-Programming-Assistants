var countSubstrings = function(s, char) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === char) {
            for (let j = i; j < s.length; j++) {
                if (s[j] === char) {
                    count++;
                }
            }
        }
    }
    return count;
};
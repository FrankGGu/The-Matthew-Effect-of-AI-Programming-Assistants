var appendCharacters = function(s, t) {
    let j = 0;
    for (let i = 0; i < s.length; i++) {
        if (j < t.length && s[i] === t[j]) {
            j++;
        }
    }
    return t.length - j;
};
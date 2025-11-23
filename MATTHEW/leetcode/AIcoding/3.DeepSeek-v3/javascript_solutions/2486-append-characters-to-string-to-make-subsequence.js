var appendCharacters = function(s, t) {
    let i = 0, j = 0;
    const n = s.length, m = t.length;

    while (i < n && j < m) {
        if (s[i] === t[j]) {
            j++;
        }
        i++;
    }

    return m - j;
};
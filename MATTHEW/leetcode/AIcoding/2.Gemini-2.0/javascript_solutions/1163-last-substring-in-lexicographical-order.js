var lastSubstring = function(s) {
    let i = 0, j = 1, k = 0;
    const n = s.length;
    while (j + k < n) {
        if (s[i + k] === s[j + k]) {
            k++;
        } else if (s[i + k] < s[j + k]) {
            i = j;
            j++;
            k = 0;
        } else {
            j++;
            k = 0;
        }
    }
    return s.substring(i);
};
var lastSubstring = function(s) {
    let n = s.length;
    let i = 0;
    let j = 1;
    let k = 0;

    while (j + k < n) {
        if (s[i + k] === s[j + k]) {
            k++;
        } else {
            if (s[i + k] < s[j + k]) {
                i = j;
            }
            j = j + k + 1;
            k = 0;
        }
    }

    return s.substring(i);
};
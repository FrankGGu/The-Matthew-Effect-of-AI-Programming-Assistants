var longestHappyPrefix = function(s) {
    const n = s.length;
    if (n === 0) {
        return "";
    }

    const lps = new Array(n).fill(0);
    let length = 0; // length of the previous longest prefix suffix
    let i = 1;

    while (i < n) {
        if (s[i] === s[length]) {
            length++;
            lps[i] = length;
            i++;
        } else {
            if (length !== 0) {
                length = lps[length - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    return s.substring(0, lps[n - 1]);
};
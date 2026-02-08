function longestPrefix(s) {
    const n = s.length;
    const lps = new Array(n).fill(0);
    let len = 0;
    for (let i = 1; i < n; ) {
        if (s[i] === s[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len !== 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }
    return s.substring(0, lps[n - 1]);
}
function maxRepOptI(s) {
    const n = s.length;
    const count = new Array(26).fill(0);
    for (let i = 0; i < n; i++) {
        count[s.charCodeAt(i) - 97]++;
    }

    let maxLen = 0;
    let i = 0;
    while (i < n) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const len = j - i;
        maxLen = Math.max(maxLen, len);
        if (j < n && j + 1 < n && s[j + 1] === s[i]) {
            let k = j + 1;
            while (k < n && s[k] === s[i]) {
                k++;
            }
            const totalLen = (k - j - 1) + len;
            maxLen = Math.max(maxLen, totalLen);
        }
        i = j;
    }

    for (let i = 0; i < n; i++) {
        let j = i + 1;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const len = j - i;
        if (len > 1) {
            maxLen = Math.max(maxLen, len + 1);
        }
    }

    return maxLen;
}
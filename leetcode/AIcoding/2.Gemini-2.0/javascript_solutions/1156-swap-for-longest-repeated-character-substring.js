var maxRepOpt1 = function(text) {
    const n = text.length;
    const count = {};
    for (const c of text) {
        count[c] = (count[c] || 0) + 1;
    }

    let maxLen = 0;
    for (let i = 0; i < n; i++) {
        let j = i;
        while (j < n && text[j] === text[i]) {
            j++;
        }
        const len = j - i;

        if (len < count[text[i]]) {
            maxLen = Math.max(maxLen, len + 1);
        } else {
            maxLen = Math.max(maxLen, len);
        }

        if (j < n) {
            let k = j;
            while (k < n && text[k] === text[i]) {
                k++;
            }
            const len2 = k - j;
            if (len + len2 < count[text[i]]) {
                maxLen = Math.max(maxLen, len + len2 + 1);
            } else {
                maxLen = Math.max(maxLen, len + len2);
            }
            i = j -1;
        } else {
            i = j-1;
        }
    }

    return maxLen;
};
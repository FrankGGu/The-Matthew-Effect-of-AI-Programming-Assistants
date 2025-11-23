var maxRepOpt1 = function(text) {
    const count = {};
    for (const c of text) {
        count[c] = (count[c] || 0) + 1;
    }

    let max = 0;
    let i = 0;
    const n = text.length;

    while (i < n) {
        let j = i;
        while (j < n && text[j] === text[i]) {
            j++;
        }
        const currentLen = j - i;
        if (currentLen < count[text[i]] && (j < n || i > 0)) {
            max = Math.max(max, currentLen + 1);
        }

        let k = j + 1;
        while (k < n && text[k] === text[i]) {
            k++;
        }
        const totalLen = k - i;
        max = Math.max(max, Math.min(totalLen, count[text[i]]));
        i = j;
    }

    return max;
};
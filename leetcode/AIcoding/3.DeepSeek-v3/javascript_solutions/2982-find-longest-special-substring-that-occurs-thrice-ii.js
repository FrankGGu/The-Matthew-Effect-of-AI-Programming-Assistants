var maximumLength = function(s) {
    const n = s.length;
    const freq = new Map();

    for (let i = 0; i < n; ) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const len = j - i;
        const char = s[i];
        if (!freq.has(char)) {
            freq.set(char, []);
        }
        freq.get(char).push(len);
        i = j;
    }

    let maxLen = -1;

    for (const [char, lengths] of freq) {
        lengths.sort((a, b) => b - a);
        const temp = [];
        for (const len of lengths) {
            temp.push(len);
            temp.push(len - 1);
            temp.push(len - 2);
        }
        temp.sort((a, b) => b - a);

        let count = 0;
        let currentMax = 0;
        for (const len of temp) {
            if (len <= 0) continue;
            count += len;
            if (count >= 3) {
                currentMax = len;
                break;
            }
        }
        if (currentMax > maxLen) {
            maxLen = currentMax;
        }
    }

    return maxLen === 0 ? -1 : maxLen;
};
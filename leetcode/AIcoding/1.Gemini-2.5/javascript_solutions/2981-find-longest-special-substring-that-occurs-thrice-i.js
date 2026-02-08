var longestSpecialSubstring = function(s) {
    let ans = -1;
    const n = s.length;

    const charLengths = new Array(26).fill(0).map(() => []);

    let i = 0;
    while (i < n) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const length = j - i;
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        charLengths[charCode].push(length);
        i = j;
    }

    for (let charCode = 0; charCode < 26; charCode++) {
        const lengths = charLengths[charCode];
        if (lengths.length === 0) {
            continue;
        }

        lengths.sort((a, b) => b - a);

        if (lengths.length >= 3) {
            if (lengths[2] > 0) {
                ans = Math.max(ans, lengths[2]);
            }
        }

        if (lengths.length >= 2) {
            if (lengths[0] > lengths[1]) {
                if (lengths[1] > 0) {
                    ans = Math.max(ans, lengths[1]);
                }
            }
        }

        if (lengths[0] - 2 > 0) {
            ans = Math.max(ans, lengths[0] - 2);
        }
    }

    return ans;
};
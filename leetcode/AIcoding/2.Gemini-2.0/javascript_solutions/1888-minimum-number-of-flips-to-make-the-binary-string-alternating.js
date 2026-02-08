var minFlips = function(s) {
    const n = s.length;
    s += s;
    let s1 = "";
    let s2 = "";
    for (let i = 0; i < 2 * n; i++) {
        s1 += (i % 2 === 0) ? '0' : '1';
        s2 += (i % 2 === 0) ? '1' : '0';
    }

    let flips1 = 0;
    let flips2 = 0;
    let minFlips = Infinity;
    for (let i = 0; i < 2 * n; i++) {
        if (s[i] !== s1[i]) {
            flips1++;
        }
        if (s[i] !== s2[i]) {
            flips2++;
        }

        if (i >= n) {
            if (s[i - n] !== s1[i - n]) {
                flips1--;
            }
            if (s[i - n] !== s2[i - n]) {
                flips2--;
            }
        }

        if (i >= n - 1) {
            minFlips = Math.min(minFlips, flips1, flips2);
        }
    }

    return minFlips;
};
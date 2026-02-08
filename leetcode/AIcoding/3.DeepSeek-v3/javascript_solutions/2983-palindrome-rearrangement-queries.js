var canMakePalindromeQueries = function(s, queries) {
    const n = s.length;
    const prefix = Array(n + 1).fill().map(() => Array(26).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < 26; j++) {
            prefix[i + 1][j] = prefix[i][j];
        }
        prefix[i + 1][s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const res = [];
    for (const [a, b, c, d] of queries) {
        let ok = true;
        const left1 = a, right1 = b;
        const left2 = c, right2 = d;
        const len1 = right1 - left1 + 1;
        const len2 = right2 - left2 + 1;
        if (len1 !== len2) {
            res.push(false);
            continue;
        }

        const outerLeft1 = 0, outerRight1 = left1 - 1;
        const outerLeft2 = right1 + 1, outerRight2 = left2 - 1;
        const outerLeft3 = right2 + 1, outerRight3 = n - 1;

        const outer1 = getFreq(prefix, outerLeft1, outerRight1);
        const outer2 = getFreq(prefix, outerLeft2, outerRight2);
        const outer3 = getFreq(prefix, outerLeft3, outerRight3);

        const outer = merge(merge(outer1, outer2), outer3);
        const inner1 = getFreq(prefix, left1, right1);
        const inner2 = getFreq(prefix, left2, right2);
        const inner = merge(inner1, inner2);

        const total = merge(outer, inner);
        for (let i = 0; i < 26; i++) {
            if (total[i] % 2 !== 0) {
                ok = false;
                break;
            }
        }
        res.push(ok);
    }
    return res;
};

function getFreq(prefix, l, r) {
    if (l > r) return Array(26).fill(0);
    const res = Array(26);
    for (let i = 0; i < 26; i++) {
        res[i] = prefix[r + 1][i] - prefix[l][i];
    }
    return res;
}

function merge(a, b) {
    const res = Array(26);
    for (let i = 0; i < 26; i++) {
        res[i] = a[i] + b[i];
    }
    return res;
}
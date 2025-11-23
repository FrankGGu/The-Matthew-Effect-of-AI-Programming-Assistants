var findGoodStrings = function(s1, s2, evil) {
    const mod = 1e9 + 7;
    const n = s1.length;
    const m = evil.length;

    const lps = computeLPS(evil);

    const memo = {};

    function dfs(pos, isPrefix1, isPrefix2, evilPos) {
        if (evilPos === m) return 0;
        if (pos === n) return 1;

        const key = `${pos},${isPrefix1},${isPrefix2},${evilPos}`;
        if (memo.hasOwnProperty(key)) return memo[key];

        let total = 0;
        const start = isPrefix1 ? s1.charCodeAt(pos) : 97;
        const end = isPrefix2 ? s2.charCodeAt(pos) : 122;

        for (let c = start; c <= end; c++) {
            const char = String.fromCharCode(c);
            let newEvilPos = evilPos;

            while (newEvilPos > 0 && char !== evil[newEvilPos]) {
                newEvilPos = lps[newEvilPos - 1];
            }
            if (char === evil[newEvilPos]) {
                newEvilPos++;
            }

            const newIsPrefix1 = isPrefix1 && (c === start);
            const newIsPrefix2 = isPrefix2 && (c === end);

            total = (total + dfs(pos + 1, newIsPrefix1, newIsPrefix2, newEvilPos)) % mod;
        }

        memo[key] = total;
        return total;
    }

    return dfs(0, true, true, 0);
};

function computeLPS(pattern) {
    const lps = new Array(pattern.length).fill(0);
    let len = 0;
    let i = 1;

    while (i < pattern.length) {
        if (pattern[i] === pattern[len]) {
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

    return lps;
}
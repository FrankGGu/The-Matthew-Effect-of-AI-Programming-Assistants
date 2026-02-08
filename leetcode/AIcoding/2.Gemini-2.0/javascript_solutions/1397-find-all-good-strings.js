var findGoodStrings = function(n, s1, s2, evil) {
    const m = evil.length;
    const MOD = 10**9 + 7;

    const computeLPS = (str) => {
        const lps = new Array(str.length).fill(0);
        let len = 0;
        let i = 1;

        while (i < str.length) {
            if (str[i] === str[len]) {
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
    };

    const lps = computeLPS(evil);

    let dp = new Array(n + 1).fill(null).map(() => new Array(m + 1).fill(null).map(() => new Array(2).fill(null).map(() => new Array(2).fill(0))));

    const solve = (idx, evilIdx, tight1, tight2) => {
        if (evilIdx === m) {
            return 0;
        }
        if (idx === n) {
            return 1;
        }

        if (dp[idx][evilIdx][tight1][tight2] !== 0) {
            return dp[idx][evilIdx][tight1][tight2];
        }

        let start = tight1 ? s1[idx].charCodeAt(0) : 'a'.charCodeAt(0);
        let end = tight2 ? s2[idx].charCodeAt(0) : 'z'.charCodeAt(0);
        let count = 0;

        for (let charCode = start; charCode <= end; charCode++) {
            let newEvilIdx = evilIdx;
            let char = String.fromCharCode(charCode);

            while (newEvilIdx > 0 && evil[newEvilIdx] !== char) {
                newEvilIdx = lps[newEvilIdx - 1];
            }

            if (evil[newEvilIdx] === char) {
                newEvilIdx++;
            }

            let newTight1 = tight1 && (char === s1[idx]);
            let newTight2 = tight2 && (char === s2[idx]);

            count = (count + solve(idx + 1, newEvilIdx, newTight1, newTight2)) % MOD;
        }

        dp[idx][evilIdx][tight1][tight2] = count;
        return count;
    };

    return solve(0, 0, 1, 1);
};
function findGoodStrings(n, s1, s2, evil) {
    const MOD = 1000000007;
    const len = s1.length;
    const m = evil.length;

    function buildKMP(pattern) {
        const kmp = new Array(pattern.length).fill(0);
        let j = 0;
        for (let i = 1; i < pattern.length; i++) {
            while (j > 0 && pattern[i] !== pattern[j]) {
                j = kmp[j - 1];
            }
            if (pattern[i] === pattern[j]) {
                j++;
                kmp[i] = j;
            } else {
                kmp[i] = 0;
            }
        }
        return kmp;
    }

    const kmp = buildKMP(evil);

    function dfs(pos, tightS1, tightS2, isPrefix, state) {
        if (pos === len) {
            return isPrefix ? 1 : 0;
        }

        let res = 0;
        const maxChar = tightS1 ? s1[pos] : 'z';
        const minChar = tightS2 ? s2[pos] : 'a';

        for (let c = minChar.charCodeAt(0); c <= maxChar.charCodeAt(0); c++) {
            const nextChar = String.fromCharCode(c);
            let nextTightS1 = tightS1 && (nextChar === s1[pos]);
            let nextTightS2 = tightS2 && (nextChar === s2[pos]);
            let nextIsPrefix = isPrefix && (nextChar === s1[pos]);

            let nextState = state;
            let j = nextState;
            while (j > 0 && nextChar !== evil[j]) {
                j = kmp[j - 1];
            }
            if (nextChar === evil[j]) {
                j++;
            }
            nextState = j;

            if (nextState === m) {
                continue;
            }

            res += dfs(pos + 1, nextTightS1, nextTightS2, nextIsPrefix, nextState);
            res %= MOD;
        }

        return res;
    }

    return dfs(0, true, true, false, 0);
}
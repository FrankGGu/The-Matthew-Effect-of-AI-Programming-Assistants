var findGoodStrings = function(n, s1, s2, evil) {
    const MOD = 10**9 + 7;
    const evilLen = evil.length;

    const lps = new Array(evilLen).fill(0);
    let length = 0;
    let i = 1;
    while (i < evilLen) {
        if (evil[i] === evil[length]) {
            length++;
            lps[i] = length;
            i++;
        } else {
            if (length !== 0) {
                length = lps[length - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    const next_state = Array(evilLen).fill(0).map(() => Array(26).fill(0));
    for (let j = 0; j < evilLen; j++) {
        for (let char_code_offset = 0; char_code_offset < 26; char_code_offset++) {
            const char = String.fromCharCode('a'.charCodeAt(0) + char_code_offset);
            if (j > 0 && evil[j] === char) {
                next_state[j][char_code_offset] = j + 1;
            } else if (j === 0 && evil[0] === char) {
                next_state[j][char_code_offset] = 1;
            } else {
                if (j === 0) {
                    next_state[j][char_code_offset] = 0;
                } else {
                    next_state[j][char_code_offset] = next_state[lps[j-1]][char_code_offset];
                }
            }
        }
    }

    const memo = new Array(n).fill(null).map(() =>
        new Array(evilLen).fill(null).map(() =>
            new Array(2).fill(null).map(() =>
                new Array(2).fill(null))));

    function dp(idx, evil_idx, tight1, tight2) {
        if (evil_idx === evilLen) {
            return 0;
        }
        if (idx === n) {
            return 1;
        }

        if (memo[idx][evil_idx][tight1][tight2] !== null) {
            return memo[idx][evil_idx][tight1][tight2];
        }

        let ans = 0;
        const lowerBound = tight1 ? s1.charCodeAt(idx) : 'a'.charCodeAt(0);
        const upperBound = tight2 ? s2.charCodeAt(idx) : 'z'.charCodeAt(0);

        for (let c = lowerBound; c <= upperBound; c++) {
            const char_code_offset = c - 'a'.charCodeAt(0);
            const newEvilIdx = next_state[evil_idx][char_code_offset];

            if (newEvilIdx === evilLen) {
                continue;
            }

            const newTight1 = tight1 && (c === lowerBound);
            const newTight2 = tight2 && (c === upperBound);

            ans = (ans + dp(idx + 1, newEvilIdx, newTight1, newTight2)) % MOD;
        }

        memo[idx][evil_idx][tight1][tight2] = ans;
        return ans;
    }

    return dp(0, 0, true, true);
};
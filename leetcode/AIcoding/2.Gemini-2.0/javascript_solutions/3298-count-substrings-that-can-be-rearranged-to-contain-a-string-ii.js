const MOD = 10**9 + 7;

var countSubstrings = function(s, t) {
    const n = s.length;
    const m = t.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const sub = s.substring(i, j + 1);
            if (canRearrange(sub, t)) {
                ans = (ans + 1) % MOD;
            }
        }
    }
    return ans;

    function canRearrange(str, target) {
        if (str.length < target.length) return false;
        const strFreq = new Array(26).fill(0);
        const targetFreq = new Array(26).fill(0);

        for (let char of target) {
            targetFreq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }

        for (let char of str) {
            strFreq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }

        for (let i = 0; i < 26; i++) {
            if (targetFreq[i] > strFreq[i]) {
                return false;
            }
        }

        return true;
    }
};
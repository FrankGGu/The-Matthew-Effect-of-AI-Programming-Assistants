var isScramble = function(s1, s2) {
    if (s1 === s2) return true;
    if (s1.length !== s2.length) return false;

    const n = s1.length;
    const memo = new Map();

    function helper(a, b) {
        const key = a + '#' + b;
        if (memo.has(key)) return memo.get(key);

        if (a === b) {
            memo.set(key, true);
            return true;
        }

        const len = a.length;
        const count = new Array(26).fill(0);

        for (let i = 0; i < len; i++) {
            count[a.charCodeAt(i) - 'a'.charCodeAt(0)]++;
            count[b.charCodeAt(i) - 'a'.charCodeAt(0)]--;
        }

        for (let i = 0; i < 26; i++) {
            if (count[i] !== 0) {
                memo.set(key, false);
                return false;
            }
        }

        for (let i = 1; i < len; i++) {
            if (helper(a.substring(0, i), b.substring(0, i)) && helper(a.substring(i), b.substring(i))) {
                memo.set(key, true);
                return true;
            }
            if (helper(a.substring(0, i), b.substring(len - i)) && helper(a.substring(i), b.substring(0, len - i))) {
                memo.set(key, true);
                return true;
            }
        }

        memo.set(key, false);
        return false;
    }

    return helper(s1, s2);
};
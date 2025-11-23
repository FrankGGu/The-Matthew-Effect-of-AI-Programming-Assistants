function isScramble(s1, s2) {
    if (s1.length !== s2.length) return false;
    if (s1 === s2) return true;

    const n = s1.length;
    const memo = {};

    function dfs(s1, s2) {
        if (s1 === s2) return true;
        if (s1.length !== s2.length) return false;

        const key = s1 + ',' + s2;
        if (key in memo) return memo[key];

        for (let i = 1; i < s1.length; i++) {
            if (dfs(s1.substring(0, i), s2.substring(0, i)) && dfs(s1.substring(i), s2.substring(i))) {
                memo[key] = true;
                return true;
            }
            if (dfs(s1.substring(0, i), s2.substring(s2.length - i)) && dfs(s1.substring(i), s2.substring(0, s2.length - i))) {
                memo[key] = true;
                return true;
            }
        }

        memo[key] = false;
        return false;
    }

    return dfs(s1, s2);
}
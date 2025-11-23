function verifyPreorder(nums) {
    let i = -1;
    function dfs(s) {
        if (i >= s.length - 1) return false;
        i++;
        if (s[i] === '#') return true;
        if (dfs(s)) return dfs(s);
        return false;
    }
    return dfs(nums.split(','));
}
function canConstruct(n, s) {
    const set = new Set();
    for (let i = 0; i < s.length; i++) {
        for (let j = i + 1; j <= Math.min(i + 30, s.length); j++) {
            set.add(s.substring(i, j));
        }
    }
    for (let i = 1; i <= n; i++) {
        if (!set.has(i.toString(2))) {
            return false;
        }
    }
    return true;
}
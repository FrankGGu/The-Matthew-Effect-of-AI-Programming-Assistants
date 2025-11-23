function longestNiceSubstring(s) {
    function isNice(sub) {
        const set = new Set(sub);
        for (const c of sub) {
            if (!set.has(c.toLowerCase()) || !set.has(c.toUpperCase())) {
                return false;
            }
        }
        return true;
    }

    let maxSub = "";
    for (let i = 0; i < s.length; i++) {
        for (let j = i + 1; j <= s.length; j++) {
            const sub = s.substring(i, j);
            if (isNice(sub) && sub.length > maxSub.length) {
                maxSub = sub;
            }
        }
    }
    return maxSub;
}
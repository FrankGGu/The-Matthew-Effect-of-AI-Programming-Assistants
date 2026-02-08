var canConstruct = function(s, k) {
    if (s.length < k) return false;
    if (s.length === k) return true;

    const counts = {};
    for (const char of s) {
        counts[char] = (counts[char] || 0) + 1;
    }

    let oddCount = 0;
    for (const char in counts) {
        if (counts[char] % 2 !== 0) {
            oddCount++;
        }
    }

    return oddCount <= k;
};
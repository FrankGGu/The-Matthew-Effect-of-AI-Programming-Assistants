var canConstruct = function(s, k) {
    if (k > s.length) return false;
    const charCount = {};
    for (const char of s) {
        charCount[char] = (charCount[char] || 0) + 1;
    }
    let oddCount = 0;
    for (const count of Object.values(charCount)) {
        if (count % 2 !== 0) oddCount++;
    }
    return oddCount <= k;
};
var canConstruct = function(s, k) {
    if (s.length < k) return false;
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }
    let oddCount = 0;
    for (const key in freq) {
        if (freq[key] % 2 !== 0) {
            oddCount++;
        }
    }
    return oddCount <= k;
};
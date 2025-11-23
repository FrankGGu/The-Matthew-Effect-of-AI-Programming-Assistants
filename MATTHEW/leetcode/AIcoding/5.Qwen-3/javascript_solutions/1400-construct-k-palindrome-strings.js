function canConstructPalindrome(s, k) {
    if (s.length < k) return false;
    const count = {};
    for (const c of s) {
        count[c] = (count[c] || 0) + 1;
    }
    let oddCount = 0;
    for (const v of Object.values(count)) {
        if (v % 2 !== 0) oddCount++;
    }
    return oddCount <= k;
}
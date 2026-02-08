var maxVowels = function(s, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let maxCount = 0, currentCount = 0;

    for (let i = 0; i < s.length; i++) {
        if (vowels.has(s[i])) currentCount++;
        if (i >= k) {
            if (vowels.has(s[i - k])) currentCount--;
        }
        maxCount = Math.max(maxCount, currentCount);
    }

    return maxCount;
};
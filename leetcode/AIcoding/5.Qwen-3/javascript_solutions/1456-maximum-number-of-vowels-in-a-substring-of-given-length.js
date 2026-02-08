function maxVowels(s, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let maxCount = 0, currentCount = 0;

    for (let i = 0; i < k; i++) {
        if (vowels.has(s[i])) {
            currentCount++;
        }
    }

    maxCount = currentCount;

    for (let i = k; i < s.length; i++) {
        if (vowels.has(s[i - k])) {
            currentCount--;
        }
        if (vowels.has(s[i])) {
            currentCount++;
        }
        maxCount = Math.max(maxCount, currentCount);
    }

    return maxCount;
}
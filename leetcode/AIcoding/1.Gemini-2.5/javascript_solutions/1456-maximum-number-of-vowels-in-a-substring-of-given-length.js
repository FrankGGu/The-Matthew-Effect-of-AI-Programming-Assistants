var maxVowels = function(s, k) {
    const isVowel = (char) => {
        return char === 'a' || char === 'e' || char === 'i' || char === 'o' || char === 'u';
    };

    let maxVowelsCount = 0;
    let currentVowelsCount = 0;

    for (let i = 0; i < k; i++) {
        if (isVowel(s[i])) {
            currentVowelsCount++;
        }
    }

    maxVowelsCount = currentVowelsCount;

    for (let i = k; i < s.length; i++) {
        if (isVowel(s[i - k])) {
            currentVowelsCount--;
        }
        if (isVowel(s[i])) {
            currentVowelsCount++;
        }
        maxVowelsCount = Math.max(maxVowelsCount, currentVowelsCount);
    }

    return maxVowelsCount;
};
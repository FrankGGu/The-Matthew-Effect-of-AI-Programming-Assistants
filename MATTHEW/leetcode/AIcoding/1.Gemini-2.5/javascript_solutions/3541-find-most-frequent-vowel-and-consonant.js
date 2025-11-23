var findMostFrequentVowelAndConsonant = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const vowelCounts = new Map();
    const consonantCounts = new Map();

    let mostFrequentVowel = '';
    let maxVowelCount = 0;
    let mostFrequentConsonant = '';
    let maxConsonantCount = 0;

    for (const char of s) {
        const lowerChar = char.toLowerCase();

        if (lowerChar >= 'a' && lowerChar <= 'z') {
            if (vowels.has(lowerChar)) {
                const currentCount = (vowelCounts.get(lowerChar) || 0) + 1;
                vowelCounts.set(lowerChar, currentCount);

                if (currentCount > maxVowelCount) {
                    maxVowelCount = currentCount;
                    mostFrequentVowel = lowerChar;
                } else if (currentCount === maxVowelCount) {
                    if (lowerChar < mostFrequentVowel) {
                        mostFrequentVowel = lowerChar;
                    }
                }
            } else {
                const currentCount = (consonantCounts.get(lowerChar) || 0) + 1;
                consonantCounts.set(lowerChar, currentCount);

                if (currentCount > maxConsonantCount) {
                    maxConsonantCount = currentCount;
                    mostFrequentConsonant = lowerChar;
                } else if (currentCount === maxConsonantCount) {
                    if (lowerChar < mostFrequentConsonant) {
                        mostFrequentConsonant = lowerChar;
                    }
                }
            }
        }
    }

    return [mostFrequentVowel, mostFrequentConsonant];
};
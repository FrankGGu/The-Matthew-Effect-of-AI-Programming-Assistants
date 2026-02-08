function mostFrequent(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const count = {};
    for (const char of s.toLowerCase()) {
        if (/[a-z]/i.test(char)) {
            count[char] = (count[char] || 0) + 1;
        }
    }

    let mostFrequentVowel = '';
    let mostFrequentConsonant = '';
    let maxVowelCount = 0;
    let maxConsonantCount = 0;

    for (const [char, freq] of Object.entries(count)) {
        if (vowels.has(char)) {
            if (freq > maxVowelCount || (freq === maxVowelCount && char < mostFrequentVowel)) {
                mostFrequentVowel = char;
                maxVowelCount = freq;
            }
        } else {
            if (freq > maxConsonantCount || (freq === maxConsonantCount && char < mostFrequentConsonant)) {
                mostFrequentConsonant = char;
                maxConsonantCount = freq;
            }
        }
    }

    return [mostFrequentVowel, mostFrequentConsonant];
}
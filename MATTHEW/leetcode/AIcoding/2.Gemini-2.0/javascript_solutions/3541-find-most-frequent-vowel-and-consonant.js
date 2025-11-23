var mostFrequentVowelAndConsonant = function(s) {
    let vowels = "aeiou";
    let vowelCounts = {};
    let consonantCounts = {};

    for (let char of s) {
        char = char.toLowerCase();
        if (vowels.includes(char)) {
            vowelCounts[char] = (vowelCounts[char] || 0) + 1;
        } else if (char >= 'a' && char <= 'z') {
            consonantCounts[char] = (consonantCounts[char] || 0) + 1;
        }
    }

    let mostFrequentVowel = '';
    let maxVowelCount = 0;
    for (let vowel in vowelCounts) {
        if (vowelCounts[vowel] > maxVowelCount) {
            maxVowelCount = vowelCounts[vowel];
            mostFrequentVowel = vowel;
        }
    }

    let mostFrequentConsonant = '';
    let maxConsonantCount = 0;
    for (let consonant in consonantCounts) {
        if (consonantCounts[consonant] > maxConsonantCount) {
            maxConsonantCount = consonantCounts[consonant];
            mostFrequentConsonant = consonant;
        }
    }

    return [mostFrequentVowel, mostFrequentConsonant];
};
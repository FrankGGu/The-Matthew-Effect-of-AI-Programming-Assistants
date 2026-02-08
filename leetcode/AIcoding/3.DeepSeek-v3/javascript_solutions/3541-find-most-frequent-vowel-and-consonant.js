var findMostFrequentVowelAndConsonant = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const freq = { vowels: {}, consonants: {} };

    for (const char of s.toLowerCase()) {
        if (/[a-z]/.test(char)) {
            if (vowels.has(char)) {
                freq.vowels[char] = (freq.vowels[char] || 0) + 1;
            } else {
                freq.consonants[char] = (freq.consonants[char] || 0) + 1;
            }
        }
    }

    let maxVowel = { char: '', count: 0 };
    for (const [char, count] of Object.entries(freq.vowels)) {
        if (count > maxVowel.count || (count === maxVowel.count && char < maxVowel.char)) {
            maxVowel = { char, count };
        }
    }

    let maxConsonant = { char: '', count: 0 };
    for (const [char, count] of Object.entries(freq.consonants)) {
        if (count > maxConsonant.count || (count === maxConsonant.count && char < maxConsonant.char)) {
            maxConsonant = { char, count };
        }
    }

    return [maxVowel.char || 'none', maxConsonant.char || 'none'];
};
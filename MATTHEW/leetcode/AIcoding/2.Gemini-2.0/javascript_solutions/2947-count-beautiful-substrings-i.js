var beautifulSubstrings = function(s, k) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            let sub = s.substring(i, j + 1);
            let vowels = 0;
            let consonants = 0;
            for (let char of sub) {
                if ('aeiou'.includes(char)) {
                    vowels++;
                } else {
                    consonants++;
                }
            }
            if (vowels === consonants && (vowels * consonants) % k === 0) {
                count++;
            }
        }
    }
    return count;
};
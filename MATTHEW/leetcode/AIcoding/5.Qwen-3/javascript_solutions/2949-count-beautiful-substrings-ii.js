function countBeautifulSubstrings(word) {
    const n = word.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        let vowels = 0;
        for (let j = i; j < n; j++) {
            if ("aeiou".includes(word[j])) {
                vowels++;
            }
            if ((j - i + 1) % 2 === 0 && vowels === (j - i + 1) / 2) {
                count++;
            }
        }
    }

    return count;
}
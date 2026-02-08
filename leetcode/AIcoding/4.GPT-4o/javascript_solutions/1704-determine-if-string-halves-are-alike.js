function areHalvesAlike(s) {
    const mid = s.length / 2;
    const firstHalf = s.slice(0, mid);
    const secondHalf = s.slice(mid);
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);

    const countVowels = (str) => {
        let count = 0;
        for (const char of str) {
            if (vowels.has(char)) count++;
        }
        return count;
    };

    return countVowels(firstHalf) === countVowels(secondHalf);
}
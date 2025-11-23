var halvesAreAlike = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    const half = s.length / 2;
    let countA = 0, countB = 0;

    for (let i = 0; i < half; i++) {
        if (vowels.has(s[i])) countA++;
    }

    for (let i = half; i < s.length; i++) {
        if (vowels.has(s[i])) countB++;
    }

    return countA === countB;
};
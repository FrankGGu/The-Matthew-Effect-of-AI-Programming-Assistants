var halvesAreAlike = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    const n = s.length;
    const mid = n / 2;
    let countA = 0;
    let countB = 0;

    for (let i = 0; i < mid; i++) {
        if (vowels.has(s[i])) {
            countA++;
        }
    }

    for (let i = mid; i < n; i++) {
        if (vowels.has(s[i])) {
            countB++;
        }
    }

    return countA === countB;
};
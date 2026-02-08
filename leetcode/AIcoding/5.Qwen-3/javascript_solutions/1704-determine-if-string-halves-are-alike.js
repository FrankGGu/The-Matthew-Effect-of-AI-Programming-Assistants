function halvesAreAlike(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    const n = s.length;
    const half = Math.floor(n / 2);
    let count = 0;
    for (let i = 0; i < half; i++) {
        if (vowels.has(s[i])) count++;
    }
    for (let i = half; i < n; i++) {
        if (vowels.has(s[i])) count--;
    }
    return count === 0;
}
function specialSubstring(s, k) {
    let count = 0;
    const n = s.length;

    for (let i = 0; i <= n - k; i++) {
        const substring = s.slice(i, i + k);
        const uniqueChars = new Set(substring);
        if (uniqueChars.size === substring.length) {
            count++;
        }
    }

    return count;
}
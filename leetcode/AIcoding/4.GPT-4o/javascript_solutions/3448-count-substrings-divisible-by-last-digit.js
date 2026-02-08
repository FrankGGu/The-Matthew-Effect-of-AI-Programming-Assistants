function countSubstrings(s) {
    let count = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const substring = s.substring(i, j + 1);
            const lastDigit = Number(substring[substring.length - 1]);
            if (lastDigit !== 0 && Number(substring) % lastDigit === 0) {
                count++;
            }
        }
    }

    return count;
}
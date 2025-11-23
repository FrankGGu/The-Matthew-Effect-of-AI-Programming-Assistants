function divisorSubstrings(num, k) {
    const s = num.toString();
    let count = 0;
    for (let i = 0; i <= s.length - k; i++) {
        const substring = s.substring(i, i + k);
        const n = parseInt(substring, 10);
        if (num % n === 0) {
            count++;
        }
    }
    return count;
}
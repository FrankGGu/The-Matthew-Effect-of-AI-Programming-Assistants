function longestPalindrome(words) {
    const count = new Map();
    for (const word of words) {
        count.set(word, (count.get(word) || 0) + 1);
    }

    let result = 0;
    let middle = 0;

    for (const [word, freq] of count.entries()) {
        const reversed = word.split('').reverse().join('');
        if (word === reversed) {
            if (freq % 2 === 1) {
                middle = 1;
            }
            result += Math.floor(freq / 2) * 2;
        } else if (count.has(reversed)) {
            const minFreq = Math.min(freq, count.get(reversed));
            result += minFreq * 2;
            count.set(reversed, 0);
        }
    }

    return result * 2 + middle;
}
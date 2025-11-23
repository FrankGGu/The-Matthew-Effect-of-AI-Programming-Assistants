function longestPalindrome(words) {
    const count = new Map();
    let pairs = 0;
    let hasOdd = false;

    for (const word of words) {
        count.set(word, (count.get(word) || 0) + 1);
    }

    for (const [word, cnt] of count) {
        if (word[0] === word[1]) {
            pairs += Math.floor(cnt / 2);
            if (cnt % 2 === 1) {
                hasOdd = true;
            }
        } else {
            const revWord = word[1] + word[0];
            if (count.has(revWord)) {
                pairs += Math.min(cnt, count.get(revWord));
            }
        }
    }

    return pairs * 2 + (hasOdd ? 1 : 0);
}
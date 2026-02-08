var vowelsGame = function(word) {
    const n = word.length;
    let count = 0;
    const vowels = ['a', 'e', 'i', 'o', 'u'];

    for (let i = 0; i < n; i++) {
        if (vowels.includes(word[i])) {
            count = (count + (i + 1) * (n - i)) % (10**9 + 7);
        }
    }

    if (count % 2 === 0) return 'Bob';
    return 'Alice';
};
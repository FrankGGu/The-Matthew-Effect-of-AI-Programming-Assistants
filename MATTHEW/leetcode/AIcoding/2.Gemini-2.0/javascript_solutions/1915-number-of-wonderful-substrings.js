var wonderfulSubstrings = function(word) {
    let count = 0;
    let mask = 0;
    let freq = new Array(1024).fill(0);
    freq[0] = 1;

    for (let i = 0; i < word.length; i++) {
        mask ^= (1 << (word.charCodeAt(i) - 'a'.charCodeAt(0)));
        count += freq[mask];
        for (let j = 0; j < 10; j++) {
            count += freq[mask ^ (1 << j)];
        }
        freq[mask]++;
    }

    return count;
};
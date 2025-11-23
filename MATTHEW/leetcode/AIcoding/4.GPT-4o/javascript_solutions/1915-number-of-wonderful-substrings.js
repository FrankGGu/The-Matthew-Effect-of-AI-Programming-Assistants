var wonderfulSubstrings = function(word) {
    const count = new Map();
    let mask = 0, result = 0;

    count.set(0, 1);

    for (const char of word) {
        mask ^= 1 << (char.charCodeAt() - 'a'.charCodeAt());
        result += count.get(mask) || 0;

        for (let i = 0; i < 10; i++) {
            result += count.get(mask ^ (1 << i)) || 0;
        }

        count.set(mask, (count.get(mask) || 0) + 1);
    }

    return result;
};
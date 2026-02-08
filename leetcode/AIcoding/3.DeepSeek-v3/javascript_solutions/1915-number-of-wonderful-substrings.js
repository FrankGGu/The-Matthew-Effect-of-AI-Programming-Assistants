var wonderfulSubstrings = function(word) {
    let count = 0;
    const prefixCount = new Array(1024).fill(0);
    prefixCount[0] = 1;
    let mask = 0;

    for (const char of word) {
        const shift = char.charCodeAt(0) - 'a'.charCodeAt(0);
        mask ^= (1 << shift);

        count += prefixCount[mask];

        for (let i = 0; i < 10; i++) {
            const tempMask = mask ^ (1 << i);
            count += prefixCount[tempMask];
        }

        prefixCount[mask]++;
    }

    return count;
};
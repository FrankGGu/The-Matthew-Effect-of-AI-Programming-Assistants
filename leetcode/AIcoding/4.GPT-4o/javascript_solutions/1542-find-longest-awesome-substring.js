var longestAwesome = function(s) {
    const n = s.length;
    const last = new Map();
    last.set(0, -1);
    let mask = 0, maxLength = 0;

    for (let i = 0; i < n; i++) {
        mask ^= 1 << (s[i] - '0');

        if (last.has(mask)) {
            maxLength = Math.max(maxLength, i - last.get(mask));
        }

        for (let j = 0; j < 10; j++) {
            const newMask = mask ^ (1 << j);
            if (last.has(newMask)) {
                maxLength = Math.max(maxLength, i - last.get(newMask));
            }
        }

        last.set(mask, i);
    }

    return maxLength;
};
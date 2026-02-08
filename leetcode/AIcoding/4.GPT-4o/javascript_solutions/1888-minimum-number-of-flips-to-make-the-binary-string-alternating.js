var minFlips = function(s) {
    const n = s.length;
    s += s; // Concatenate string to handle wraparound
    let count1 = 0, count2 = 0;

    for (let i = 0; i < n; i++) {
        count1 += s[i] !== (i % 2 === 0 ? '0' : '1');
        count2 += s[i] !== (i % 2 === 0 ? '1' : '0');
    }

    let minFlips = Math.min(count1, count2);
    for (let i = n; i < s.length; i++) {
        count1 += s[i] !== (i % 2 === 0 ? '0' : '1') ? 1 : 0;
        count1 -= s[i - n] !== (i - n % 2 === 0 ? '0' : '1') ? 1 : 0;

        count2 += s[i] !== (i % 2 === 0 ? '1' : '0') ? 1 : 0;
        count2 -= s[i - n] !== (i - n % 2 === 0 ? '1' : '0') ? 1 : 0;

        minFlips = Math.min(minFlips, Math.min(count1, count2));
    }

    return minFlips;
};
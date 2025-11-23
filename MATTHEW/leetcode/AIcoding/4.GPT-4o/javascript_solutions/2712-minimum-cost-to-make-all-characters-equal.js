var minimumCost = function(s) {
    const count = Array(26).fill(0);
    for (let char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    let totalCost = 0;
    const n = s.length;
    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            totalCost += count[i] * (n - count[i]);
        }
    }
    return totalCost / 2;
};
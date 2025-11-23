var secondHighest = function(s) {
    let digits = new Set();
    for (let c of s) {
        if (c >= '0' && c <= '9') {
            digits.add(parseInt(c));
        }
    }
    if (digits.size < 2) {
        return -1;
    }
    let sorted = Array.from(digits).sort((a, b) => b - a);
    return sorted[1];
};
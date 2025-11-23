var rotatedDigits = function(n) {
    let count = 0;
    for (let i = 1; i <= n; i++) {
        const s = i.toString();
        if (s.includes('3') || s.includes('4') || s.includes('7')) {
            continue;
        }
        if (s.includes('2') || s.includes('5') || s.includes('6') || s.includes('9')) {
            count++;
        }
    }
    return count;
};
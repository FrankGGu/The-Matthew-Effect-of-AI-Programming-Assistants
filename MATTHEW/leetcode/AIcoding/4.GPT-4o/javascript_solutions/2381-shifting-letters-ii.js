var shiftingLetters = function(s, shifts) {
    const n = s.length;
    const result = Array(n).fill(0);
    let totalShift = 0;

    for (let i = n - 1; i >= 0; i--) {
        totalShift = (totalShift + shifts[i]) % 26;
        result[i] = String.fromCharCode(((s.charCodeAt(i) - 97 + totalShift) % 26) + 97);
    }

    return result.join('');
};
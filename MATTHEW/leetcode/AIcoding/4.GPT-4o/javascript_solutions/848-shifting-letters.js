var shiftingLetters = function(s, shifts) {
    let n = s.length;
    let result = [];
    let totalShift = 0;

    for (let i = n - 1; i >= 0; i--) {
        totalShift = (totalShift + shifts[i]) % 26;
        let newCharCode = ((s.charCodeAt(i) - 97 + totalShift) % 26) + 97;
        result.push(String.fromCharCode(newCharCode));
    }

    return result.reverse().join('');
};
var shiftingLetters = function(s, shifts) {
    let totalShift = 0;
    let result = [];
    for (let i = shifts.length - 1; i >= 0; i--) {
        totalShift += shifts[i];
        let charCode = s.charCodeAt(i) - 97;
        let shiftedCharCode = (charCode + totalShift) % 26;
        result[i] = String.fromCharCode(shiftedCharCode + 97);
    }
    return result.join('');
};
var shiftingLetters = function(s, shifts) {
    let n = s.length;
    let shiftVal = 0;
    let result = "";

    for (let i = n - 1; i >= 0; i--) {
        shiftVal = (shiftVal + shifts[i]) % 26;
        let charCode = s.charCodeAt(i) - 97;
        let newCharCode = (charCode + shiftVal) % 26;
        result = String.fromCharCode(newCharCode + 97) + result;
    }

    return result;
};
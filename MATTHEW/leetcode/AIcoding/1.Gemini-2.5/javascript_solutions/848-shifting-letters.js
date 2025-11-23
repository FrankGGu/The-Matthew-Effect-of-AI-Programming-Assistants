var shiftingLetters = function(s, shifts) {
    const n = s.length;
    const resultChars = new Array(n);
    let currentTotalShift = 0;

    for (let i = n - 1; i >= 0; i--) {
        currentTotalShift = (currentTotalShift + shifts[i]) % 26;

        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        const shiftedCharCode = (charCode + currentTotalShift) % 26;

        resultChars[i] = String.fromCharCode(shiftedCharCode + 'a'.charCodeAt(0));
    }

    return resultChars.join('');
};
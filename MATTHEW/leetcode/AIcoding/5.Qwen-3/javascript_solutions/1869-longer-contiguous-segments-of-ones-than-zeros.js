function checkZeroOnes(s) {
    let maxOne = 0, maxZero = 0;
    let currentOne = 0, currentZero = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            currentOne++;
            currentZero = 0;
            maxOne = Math.max(maxOne, currentOne);
        } else {
            currentZero++;
            currentOne = 0;
            maxZero = Math.max(maxZero, currentZero);
        }
    }

    return maxOne > maxZero;
}
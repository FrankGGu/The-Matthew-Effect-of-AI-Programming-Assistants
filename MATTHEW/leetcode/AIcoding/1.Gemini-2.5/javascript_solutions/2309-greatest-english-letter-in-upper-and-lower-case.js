var greatestLetter = function(s) {
    const charSet = new Set();
    for (const char of s) {
        charSet.add(char);
    }

    for (let i = 25; i >= 0; i--) {
        const upperChar = String.fromCharCode('A'.charCodeAt(0) + i);
        const lowerChar = String.fromCharCode('a'.charCodeAt(0) + i);

        if (charSet.has(upperChar) && charSet.has(lowerChar)) {
            return upperChar;
        }
    }

    return "";
};
var areDigitsEqual = function(s) {
    let chars = s.split('');

    for (let i = 0; i < s.length / 2; i++) {
        const idx1 = 2 * i;
        const idx2 = 2 * i + 1;

        const char1 = chars[idx1];
        const char2 = chars[idx2];

        if (char1 !== char2) {
            const num1 = parseInt(char1);
            const num2 = parseInt(char2);

            const minVal = Math.min(num1, num2);
            const maxVal = Math.max(num1, num2);

            chars[idx1] = String(minVal);
            chars[idx2] = String(maxVal);
        }
    }

    const firstChar = chars[0];
    for (let i = 1; i < chars.length; i++) {
        if (chars[i] !== firstChar) {
            return false;
        }
    }

    return true;
};
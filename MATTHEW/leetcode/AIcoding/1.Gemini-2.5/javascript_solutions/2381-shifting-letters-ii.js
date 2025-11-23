var shiftingLetters = function(s, shifts) {
    const n = s.length;
    const diff = new Array(n + 1).fill(0);

    for (const shift of shifts) {
        const start = shift[0];
        const end = shift[1];
        const direction = shift[2];

        if (direction === 1) { // Clockwise shift (a -> b)
            diff[start]++;
            if (end + 1 < n + 1) {
                diff[end + 1]--;
            }
        } else { // Counter-clockwise shift (b -> a)
            diff[start]--;
            if (end + 1 < n + 1) {
                diff[end + 1]++;
            }
        }
    }

    const result = new Array(n);
    let currentShift = 0;
    const aCharCode = 'a'.charCodeAt(0);

    for (let i = 0; i < n; i++) {
        currentShift += diff[i];

        const originalCharOffset = s.charCodeAt(i) - aCharCode;
        let shiftedCharOffset = originalCharOffset + currentShift;

        // Apply modulo 26 to handle wrapping around, ensuring the result is always positive
        // (shiftedCharOffset % 26 + 26) % 26 handles negative results correctly in JavaScript
        shiftedCharOffset = (shiftedCharOffset % 26 + 26) % 26;

        result[i] = String.fromCharCode(shiftedCharOffset + aCharCode);
    }

    return result.join('');
};
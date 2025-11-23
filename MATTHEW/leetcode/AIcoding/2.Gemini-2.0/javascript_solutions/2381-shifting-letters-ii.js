var shiftingLetters = function(s, shifts) {
    const n = s.length;
    const diff = new Array(n).fill(0);

    for (const shift of shifts) {
        const start = shift[0];
        const end = shift[1];
        const direction = shift[2];

        if (direction === 1) {
            diff[start] += 1;
            if (end + 1 < n) {
                diff[end + 1] -= 1;
            }
        } else {
            diff[start] -= 1;
            if (end + 1 < n) {
                diff[end + 1] += 1;
            }
        }
    }

    const result = [];
    let currentShift = 0;
    for (let i = 0; i < n; i++) {
        currentShift += diff[i];
        let charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        charCode = (charCode + currentShift) % 26;
        if (charCode < 0) {
            charCode += 26;
        }
        result.push(String.fromCharCode(charCode + 'a'.charCodeAt(0)));
    }

    return result.join('');
};
var shiftingLetters = function(s, shifts) {
    const n = s.length;
    const diff = new Array(n + 1).fill(0);

    for (const [start, end, direction] of shifts) {
        const delta = direction === 1 ? 1 : -1;
        diff[start] += delta;
        if (end + 1 < n) {
            diff[end + 1] -= delta;
        }
    }

    let shift = 0;
    let result = [];
    for (let i = 0; i < n; i++) {
        shift += diff[i];
        let charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        charCode = (charCode + shift) % 26;
        if (charCode < 0) charCode += 26;
        result.push(String.fromCharCode(charCode + 'a'.charCodeAt(0)));
    }

    return result.join('');
};
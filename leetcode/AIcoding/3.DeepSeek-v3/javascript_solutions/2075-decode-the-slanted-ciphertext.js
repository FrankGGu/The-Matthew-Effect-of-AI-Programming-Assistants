var decodeCiphertext = function(encodedText, rows) {
    if (rows === 1) return encodedText;
    const n = encodedText.length;
    const cols = Math.floor(n / rows);
    let res = [];
    for (let i = 0; i < cols; i++) {
        for (let j = 0; j < rows; j++) {
            const pos = j * cols + (i + j);
            if (pos >= n) break;
            res.push(encodedText[pos]);
        }
    }
    while (res.length > 0 && res[res.length - 1] === ' ') {
        res.pop();
    }
    return res.join('');
};
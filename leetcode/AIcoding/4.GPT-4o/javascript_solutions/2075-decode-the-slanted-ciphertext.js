function decodeCiphertext(encodedText, rows) {
    if (rows === 0 || encodedText.length === 0) return "";
    const cols = encodedText.length / rows;
    let result = "";

    for (let col = 0; col < cols; col++) {
        for (let row = 0; row < rows; row++) {
            const index = row + col;
            if (index < cols) {
                const char = encodedText[row * cols + index];
                if (char !== ' ') {
                    result += char;
                }
            }
        }
    }

    return result.trimEnd();
}
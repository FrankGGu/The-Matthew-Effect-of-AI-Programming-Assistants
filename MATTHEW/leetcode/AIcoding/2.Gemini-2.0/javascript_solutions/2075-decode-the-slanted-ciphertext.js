var decodeCiphertext = function(encodedText, rows) {
    const n = encodedText.length;
    const cols = n / rows;
    if (n % rows !== 0) return "";
    let decodedText = "";
    for (let col = 0; col < cols; col++) {
        let row = 0;
        let currCol = col;
        while (row < rows && currCol < cols) {
            decodedText += encodedText[row * cols + currCol];
            row++;
            currCol++;
        }
    }
    return decodedText.trimEnd();
};
function decodeAtIndex(s, k) {
    let totalLength = 0;
    for (let char of s) {
        if (char >= '0' && char <= '9') {
            totalLength *= parseInt(char);
        } else {
            totalLength++;
        }
    }

    for (let i = s.length - 1; i >= 0; i--) {
        let char = s[i];
        if (char >= '0' && char <= '9') {
            totalLength /= parseInt(char);
        } else {
            if (totalLength === k) {
                return char;
            }
            totalLength--;
        }
    }
    return '';
}
function countHomogenous(s) {
    let count = 0;
    let prevChar = '';
    let sameCount = 0;

    for (const char of s) {
        if (char === prevChar) {
            sameCount++;
        } else {
            sameCount = 1;
        }
        count += sameCount;
        prevChar = char;
    }

    return count;
}
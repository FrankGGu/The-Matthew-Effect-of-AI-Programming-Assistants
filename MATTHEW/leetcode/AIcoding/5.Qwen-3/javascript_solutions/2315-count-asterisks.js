function countAsterisks(s) {
    let count = 0;
    let inBold = false;
    for (let char of s) {
        if (char === '*') {
            if (!inBold) count++;
        } else if (char === '|') {
            inBold = !inBold;
        }
    }
    return count;
}
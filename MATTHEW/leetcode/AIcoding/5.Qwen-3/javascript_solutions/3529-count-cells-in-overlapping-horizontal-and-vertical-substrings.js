function countCells(s) {
    const n = s.length;
    let result = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (s[i] === s[j]) {
                result++;
            }
        }
    }
    return result;
}
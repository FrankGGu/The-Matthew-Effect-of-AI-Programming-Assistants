function cellsInRange(s) {
    const start = s[0];
    const end = s[2];
    const startNum = parseInt(s.slice(1));
    const endNum = parseInt(s.slice(3));
    const result = [];
    for (let col = start.charCodeAt(0); col <= end.charCodeAt(0); col++) {
        for (let row = startNum; row <= endNum; row++) {
            result.push(String.fromCharCode(col) + row);
        }
    }
    return result;
}
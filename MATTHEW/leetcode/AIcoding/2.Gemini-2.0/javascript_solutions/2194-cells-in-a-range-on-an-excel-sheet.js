var cellsInRange = function(s) {
    const startCol = s.charCodeAt(0);
    const startRow = parseInt(s[1]);
    const endCol = s.charCodeAt(3);
    const endRow = parseInt(s[4]);

    const result = [];

    for (let col = startCol; col <= endCol; col++) {
        for (let row = startRow; row <= endRow; row++) {
            result.push(String.fromCharCode(col) + row);
        }
    }

    return result;
};
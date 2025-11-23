var cellsInRange = function(s) {
    const [startCol, startRow, , endCol, endRow] = s.split('');
    const result = [];

    for (let col = startCol.charCodeAt(0); col <= endCol.charCodeAt(0); col++) {
        for (let row = parseInt(startRow); row <= parseInt(endRow); row++) {
            result.push(String.fromCharCode(col) + row.toString());
        }
    }

    return result;
};
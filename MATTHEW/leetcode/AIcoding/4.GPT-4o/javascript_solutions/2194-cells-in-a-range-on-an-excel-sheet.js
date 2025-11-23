var cellsInRange = function(s) {
    const result = [];
    const [start, end] = s.split(':');
    const startCol = start.charCodeAt(0);
    const endCol = end.charCodeAt(0);
    const startRow = parseInt(start.slice(1));
    const endRow = parseInt(end.slice(1));

    for (let col = startCol; col <= endCol; col++) {
        for (let row = startRow; row <= endRow; row++) {
            result.push(String.fromCharCode(col) + row);
        }
    }

    return result;
};
var getRow = function(rowIndex) {
    let row = [1];
    for (let i = 1; i <= rowIndex; i++) {
        let nextRow = [1];
        for (let j = 1; j < i; j++) {
            nextRow.push(row[j - 1] + row[j]);
        }
        nextRow.push(1);
        row = nextRow;
    }
    return row;
};
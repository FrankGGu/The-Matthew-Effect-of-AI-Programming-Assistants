function getRow(rowIndex) {
    let row = [1];
    for (let i = 1; i <= rowIndex; i++) {
        row[i] = row[i - 1] * (rowIndex - i + 1) / i;
    }
    return row;
}
function generate(numRows) {
    const triangle = [];
    for (let i = 0; i < numRows; i++) {
        const row = [1];
        if (i > 0) {
            for (let j = 1; j < i; j++) {
                row.push(triangle[i - 1][j - 1] + triangle[i - 1][j]);
            }
            row.push(1);
        }
        triangle.push(row);
    }
    return triangle;
}
var generate = function(numRows) {
    const triangle = [];

    if (numRows === 0) {
        return triangle;
    }

    triangle.push([1]);

    for (let i = 1; i < numRows; i++) {
        const prevRow = triangle[i - 1];
        const currentRow = [1];

        for (let j = 1; j < prevRow.length; j++) {
            currentRow.push(prevRow[j - 1] + prevRow[j]);
        }

        currentRow.push(1);
        triangle.push(currentRow);
    }

    return triangle;
};
var findLexicographicallyLargestString = function(box) {
    const numCols = box.length;
    const resultChars = [];

    for (let j = 0; j < numCols; j++) {
        const currentColumn = box[j];
        let maxCharInColumn = currentColumn[0]; 

        for (let i = 1; i < currentColumn.length; i++) {
            if (currentColumn[i] > maxCharInColumn) {
                maxCharInColumn = currentColumn[i];
            }
        }
        resultChars.push(maxCharInColumn);
    }

    return resultChars.join('');
};
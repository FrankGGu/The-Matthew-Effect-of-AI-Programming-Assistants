function findLexicographicallyLargestString(box) {
    let result = '';
    for (let i = 0; i < box.length; i++) {
        for (let j = 0; j < box[i].length; j++) {
            if (box[i][j] > result) {
                result = box[i][j];
            }
        }
    }
    return result;
}
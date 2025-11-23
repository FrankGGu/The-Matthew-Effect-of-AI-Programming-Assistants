var cellsInRange = function(s) {
    const result = [];
    const startColChar = s[0];
    const startRow = parseInt(s[1]);
    const endColChar = s[3];
    const endRow = parseInt(s[4]);

    for (let colCode = startColChar.charCodeAt(0); colCode <= endColChar.charCodeAt(0); colCode++) {
        const currentColChar = String.fromCharCode(colCode);
        for (let row = startRow; row <= endRow; row++) {
            result.push(currentColChar + row);
        }
    }

    return result;
};
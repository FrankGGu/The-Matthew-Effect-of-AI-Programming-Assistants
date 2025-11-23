var convertToTitle = function(columnNumber) {
    let result = '';
    while (columnNumber > 0) {
        columnNumber--;
        let char = String.fromCharCode('A'.charCodeAt(0) + columnNumber % 26);
        result = char + result;
        columnNumber = Math.floor(columnNumber / 26);
    }
    return result;
};
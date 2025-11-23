var convertToTitle = function(columnNumber) {
    let result = [];
    while (columnNumber > 0) {
        columnNumber--; // Adjust for 0-based remainder calculation (A=0, B=1, ..., Z=25)
        const remainder = columnNumber % 26;
        result.push(String.fromCharCode('A'.charCodeAt(0) + remainder));
        columnNumber = Math.floor(columnNumber / 26);
    }
    return result.reverse().join('');
};
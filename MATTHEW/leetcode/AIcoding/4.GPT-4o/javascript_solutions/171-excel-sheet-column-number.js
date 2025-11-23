var titleToNumber = function(columnTitle) {
    let result = 0;
    let length = columnTitle.length;
    for (let i = 0; i < length; i++) {
        result = result * 26 + (columnTitle.charCodeAt(i) - 'A'.charCodeAt(0) + 1);
    }
    return result;
};
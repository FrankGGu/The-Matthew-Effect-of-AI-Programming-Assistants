var titleToNumber = function(columnTitle) {
    let result = 0;
    for (let i = 0; i < columnTitle.length; i++) {
        result = result * 26 + (columnTitle.charCodeAt(i) - 'A'.charCodeAt(0) + 1);
    }
    return result;
};
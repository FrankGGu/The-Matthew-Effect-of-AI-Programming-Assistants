var countBeautifulNumbers = function(low, high) {
    let count = 0;
    for (let i = low; i <= high; i++) {
        let numStr = i.toString();
        let uniqueDigits = new Set(numStr);
        if (uniqueDigits.size === numStr.length) {
            count++;
        }
    }
    return count;
};
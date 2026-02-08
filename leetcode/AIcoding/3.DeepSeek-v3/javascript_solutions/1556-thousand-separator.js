var thousandSeparator = function(n) {
    let str = n.toString();
    let result = [];
    let count = 0;
    for (let i = str.length - 1; i >= 0; i--) {
        result.unshift(str[i]);
        count++;
        if (count % 3 === 0 && i !== 0) {
            result.unshift('.');
        }
    }
    return result.join('');
};
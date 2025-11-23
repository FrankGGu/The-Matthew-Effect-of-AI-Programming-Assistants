var canWin = function(num) {
    let count = 0;
    for (let digit of num) {
        if (digit === '9') {
            count++;
        }
    }
    return count % 2 === 1;
};
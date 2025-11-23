var sumOfNumberAndReverse = function(num) {
    for (let i = 0; i <= num; i++) {
        const reversed = parseInt(i.toString().split('').reverse().join(''));
        if (i + reversed === num) {
            return true;
        }
    }
    return false;
};
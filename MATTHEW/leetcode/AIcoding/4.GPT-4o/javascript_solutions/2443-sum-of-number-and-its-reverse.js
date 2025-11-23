var sumOfNumberAndReverse = function(num) {
    for (let i = 0; i <= num; i++) {
        let reversed = parseInt(i.toString().split('').reverse().join(''), 10);
        if (i + reversed === num) {
            return true;
        }
    }
    return false;
};
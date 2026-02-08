var sortByBits = function(arr) {
    arr.sort((a, b) => {
        const countA = a.toString(2).split('').filter(bit => bit === '1').length;
        const countB = b.toString(2).split('').filter(bit => bit === '1').length;
        if (countA !== countB) {
            return countA - countB;
        } else {
            return a - b;
        }
    });
    return arr;
};
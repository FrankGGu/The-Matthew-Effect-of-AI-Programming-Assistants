var sortByBits = function(arr) {
    return arr.sort((a, b) => {
        let countA = a.toString(2).split('0').join('').length;
        let countB = b.toString(2).split('0').join('').length;
        return countA === countB ? a - b : countA - countB;
    });
};
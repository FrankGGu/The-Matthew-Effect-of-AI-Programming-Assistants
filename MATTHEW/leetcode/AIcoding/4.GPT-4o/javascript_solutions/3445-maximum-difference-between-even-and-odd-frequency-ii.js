var maximumDifference = function(nums) {
    let maxEven = -1, maxOdd = -1, minEven = Infinity, minOdd = Infinity;

    for (let num of nums) {
        if (num % 2 === 0) {
            maxEven = Math.max(maxEven, num);
            minEven = Math.min(minEven, num);
        } else {
            maxOdd = Math.max(maxOdd, num);
            minOdd = Math.min(minOdd, num);
        }
    }

    let evenDiff = maxEven - minOdd;
    let oddDiff = maxOdd - minEven;

    return Math.max(evenDiff, oddDiff);
};
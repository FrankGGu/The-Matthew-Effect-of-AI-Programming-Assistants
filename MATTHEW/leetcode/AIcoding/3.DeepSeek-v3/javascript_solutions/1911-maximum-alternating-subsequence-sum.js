var maxAlternatingSum = function(nums) {
    let even = 0, odd = 0;
    for (let num of nums) {
        let newEven = Math.max(even, odd + num);
        let newOdd = Math.max(odd, even - num);
        even = newEven;
        odd = newOdd;
    }
    return Math.max(even, odd);
};
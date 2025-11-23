var maxAlternatingSum = function(nums) {
    let even = 0;
    let odd = 0;

    for (let i = 0; i < nums.length; i++) {
        let newEven = Math.max(even, odd + nums[i]);
        let newOdd = Math.max(odd, even - nums[i]);
        even = newEven;
        odd = newOdd;
    }

    return even;
};
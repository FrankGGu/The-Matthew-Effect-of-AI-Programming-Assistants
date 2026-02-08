var findNumbers = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        let digits = 0;
        if (num === 0) {
            digits = 1;
        } else {
            digits = Math.floor(Math.log10(num)) + 1;
        }

        // Alternative: Convert to string and get length
        // let digits = String(num).length;

        if (digits % 2 === 0) {
            count++;
        }
    }
    return count;
};
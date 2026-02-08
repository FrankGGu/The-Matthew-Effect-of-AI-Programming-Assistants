var Solution = function(nums) {
    this.nums = nums;
};

Solution.prototype.pick = function(target) {
    let count = 0;
    let result = -1;

    for (let i = 0; i < this.nums.length; i++) {
        if (this.nums[i] === target) {
            count++;
            // With probability 1/count, update the result
            // This ensures each occurrence has an equal chance of being picked
            if (Math.floor(Math.random() * count) === 0) {
                result = i;
            }
        }
    }
    return result;
};
var Solution = function(nums) {
    this.nums = nums;
};

Solution.prototype.pick = function(target) {
    let indices = [];
    for (let i = 0; i < this.nums.length; i++) {
        if (this.nums[i] === target) {
            indices.push(i);
        }
    }
    return indices[Math.floor(Math.random() * indices.length)];
};
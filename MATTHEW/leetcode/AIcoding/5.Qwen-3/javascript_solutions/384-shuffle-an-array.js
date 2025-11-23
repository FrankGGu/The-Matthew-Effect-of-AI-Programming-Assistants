var Solution = function(nums) {
    this.nums = nums;
};

Solution.prototype.reset = function() {
    return this.nums;
};

Solution.prototype.shuffle = function() {
    let arr = this.nums.slice();
    for (let i = arr.length - 1; i > 0; i--) {
        let j = Math.floor(Math.random() * (i + 1));
        [arr[i], arr[j]] = [arr[j], arr[i]];
    }
    return arr;
};
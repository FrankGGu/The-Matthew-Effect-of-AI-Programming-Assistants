var Solution = function(nums) {
    this.map = {};
    for (let i = 0; i < nums.length; i++) {
        if (!this.map[nums[i]]) {
            this.map[nums[i]] = [];
        }
        this.map[nums[i]].push(i);
    }
};

Solution.prototype.pick = function(target) {
    const indices = this.map[target];
    const randomIndex = Math.floor(Math.random() * indices.length);
    return indices[randomIndex];
};
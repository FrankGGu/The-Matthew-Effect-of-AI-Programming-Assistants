var Solution = function(nums) {
    this.original = [...nums];
    this.array = nums;
};

Solution.prototype.reset = function() {
    this.array = [...this.original];
    return this.array;
};

Solution.prototype.shuffle = function() {
    const shuffled = [...this.array];
    for (let i = shuffled.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    }
    return shuffled;
};
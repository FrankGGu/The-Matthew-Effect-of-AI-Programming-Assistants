var Solution = function(nums) {
    this.original = [...nums];
    this.current = [...nums];
};

Solution.prototype.reset = function() {
    this.current = [...this.original];
    return this.current;
};

Solution.prototype.shuffle = function() {
    let n = this.current.length;
    for (let i = n - 1; i > 0; i--) {
        let j = Math.floor(Math.random() * (i + 1));
        [this.current[i], this.current[j]] = [this.current[j], this.current[i]];
    }
    return this.current;
};
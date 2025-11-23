var MyStack = function() {
    this.q1 = [];
    this.q2 = [];
};

MyStack.prototype.push = function(x) {
    this.q1.push(x);
};

MyStack.prototype.pop = function() {
    while (this.q1.length > 1) {
        this.q2.push(this.q1.shift());
    }
    let top = this.q1.shift();
    [this.q1, this.q2] = [this.q2, this.q1];
    return top;
};

MyStack.prototype.top = function() {
    while (this.q1.length > 1) {
        this.q2.push(this.q1.shift());
    }
    let top = this.q1[0];
    this.q2.push(this.q1.shift());
    [this.q1, this.q2] = [this.q2, this.q1];
    return top;
};

MyStack.prototype.empty = function() {
    return this.q1.length === 0;
};
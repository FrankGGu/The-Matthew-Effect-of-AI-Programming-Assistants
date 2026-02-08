var MyStack = function() {
    this.q1 = [];
    this.q2 = [];
};

MyStack.prototype.push = function(x) {
    this.q2.push(x);

    while (this.q1.length > 0) {
        this.q2.push(this.q1.shift());
    }

    let temp = this.q1;
    this.q1 = this.q2;
    this.q2 = temp;
};

MyStack.prototype.pop = function() {
    return this.q1.shift();
};

MyStack.prototype.top = function() {
    return this.q1[0];
};

MyStack.prototype.empty = function() {
    return this.q1.length === 0;
};
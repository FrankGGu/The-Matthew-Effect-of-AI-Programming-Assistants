var FooBar = function(n) {
    this.n = n;
};

FooBar.prototype.foo = function(printFoo) {
    for (let i = 0; i < this.n; i++) {
        printFoo();
    }
};

FooBar.prototype.bar = function(printBar) {
    for (let i = 0; i < this.n; i++) {
        printBar();
    }
};
var BrowserHistory = function(homepage) {
    this.history = [homepage];
    this.current = 0;
};

BrowserHistory.prototype.visit = function(url) {
    this.history.length = this.current + 1;
    this.history.push(url);
    this.current++;
};

BrowserHistory.prototype.back = function(steps) {
    this.current = Math.max(this.current - steps, 0);
    return this.history[this.current];
};

BrowserHistory.prototype.forward = function(steps) {
    this.current = Math.min(this.current + steps, this.history.length - 1);
    return this.history[this.current];
};
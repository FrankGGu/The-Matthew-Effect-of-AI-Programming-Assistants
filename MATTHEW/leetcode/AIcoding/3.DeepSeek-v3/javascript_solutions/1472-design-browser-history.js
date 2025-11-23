var BrowserHistory = function(homepage) {
    this.history = [homepage];
    this.current = 0;
};

BrowserHistory.prototype.visit = function(url) {
    this.history = this.history.slice(0, this.current + 1);
    this.history.push(url);
    this.current++;
};

BrowserHistory.prototype.back = function(steps) {
    this.current = Math.max(0, this.current - steps);
    return this.history[this.current];
};

BrowserHistory.prototype.forward = function(steps) {
    this.current = Math.min(this.history.length - 1, this.current + steps);
    return this.history[this.current];
};
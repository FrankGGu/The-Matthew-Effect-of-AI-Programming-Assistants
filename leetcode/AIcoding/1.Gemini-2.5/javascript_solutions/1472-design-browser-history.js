var BrowserHistory = function(homepage) {
    this.history = [homepage];
    this.currentIndex = 0;
    this.maxIndex = 0;
};

BrowserHistory.prototype.visit = function(url) {
    this.currentIndex++;
    this.history[this.currentIndex] = url;
    this.maxIndex = this.currentIndex;
    this.history.length = this.currentIndex + 1;
};

BrowserHistory.prototype.back = function(steps) {
    this.currentIndex = Math.max(0, this.currentIndex - steps);
    return this.history[this.currentIndex];
};

BrowserHistory.prototype.forward = function(steps) {
    this.currentIndex = Math.min(this.maxIndex, this.currentIndex + steps);
    return this.history[this.currentIndex];
};
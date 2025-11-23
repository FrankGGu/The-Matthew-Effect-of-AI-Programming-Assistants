var MyCalendar = function() {
    this.books = [];
};

MyCalendar.prototype.book = function(start, end) {
    for (let [s, e] of this.books) {
        if (Math.max(s, start) < Math.min(e, end)) {
            return false;
        }
    }
    this.books.push([start, end]);
    return true;
};
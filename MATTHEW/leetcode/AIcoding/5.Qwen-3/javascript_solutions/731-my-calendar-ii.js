var MyCalendarTwo = function() {
    this.books = [];
};

MyCalendarTwo.prototype.book = function(start, end) {
    for (let i = 0; i < this.books.length; i++) {
        const [s, e] = this.books[i];
        if (start < e && end > s) {
            return false;
        }
    }
    this.books.push([start, end]);
    return true;
};
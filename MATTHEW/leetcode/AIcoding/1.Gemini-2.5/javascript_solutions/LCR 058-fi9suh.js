var MyCalendar = function() {
    this.calendar = [];
};

MyCalendar.prototype.book = function(start, end) {
    for (const [s, e] of this.calendar) {
        if (start < e && end > s) {
            return false;
        }
    }
    this.calendar.push([start, end]);
    return true;
};
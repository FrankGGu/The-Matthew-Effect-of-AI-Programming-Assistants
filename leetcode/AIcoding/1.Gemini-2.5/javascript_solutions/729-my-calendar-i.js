var MyCalendar = function() {
    this.events = [];
};

MyCalendar.prototype.book = function(start, end) {
    for (const [s, e] of this.events) {
        if (start < e && s < end) {
            return false;
        }
    }
    this.events.push([start, end]);
    return true;
};
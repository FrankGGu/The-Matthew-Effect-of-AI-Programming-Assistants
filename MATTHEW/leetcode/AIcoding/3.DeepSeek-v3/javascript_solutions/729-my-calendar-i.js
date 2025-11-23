var MyCalendar = function() {
    this.events = [];
};

MyCalendar.prototype.book = function(start, end) {
    for (const event of this.events) {
        if (start < event[1] && end > event[0]) {
            return false;
        }
    }
    this.events.push([start, end]);
    return true;
};
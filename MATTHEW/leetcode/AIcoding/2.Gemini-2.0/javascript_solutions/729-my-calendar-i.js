var MyCalendar = function() {
    this.calendar = [];
};

MyCalendar.prototype.book = function(start, end) {
    for (let i = 0; i < this.calendar.length; i++) {
        let existingStart = this.calendar[i][0];
        let existingEnd = this.calendar[i][1];

        if (start < existingEnd && end > existingStart) {
            return false;
        }
    }

    this.calendar.push([start, end]);
    return true;
};
var dayOfYear = function(date) {
    const parts = date.split('-');
    const year = parseInt(parts[0]);
    const month = parseInt(parts[1]);
    const day = parseInt(parts[2]);

    const daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    const isLeap = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);

    if (isLeap) {
        daysInMonth[2] = 29;
    }

    let dayCount = 0;
    for (let i = 1; i < month; i++) {
        dayCount += daysInMonth[i];
    }

    dayCount += day;

    return dayCount;
};
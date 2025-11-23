var dayOfYear = function(date) {
    const [year, month, day] = date.split('-').map(Number);
    const daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if ((year % 4 === 0 && year % 100 !== 0) || year % 400 === 0) {
        daysInMonth[2] = 29;
    }

    let dayOfYear = 0;
    for (let i = 1; i < month; i++) {
        dayOfYear += daysInMonth[i];
    }
    dayOfYear += day;

    return dayOfYear;
};
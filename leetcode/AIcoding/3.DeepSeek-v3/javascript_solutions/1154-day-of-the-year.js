var dayOfYear = function(date) {
    const [year, month, day] = date.split('-').map(Number);
    const isLeapYear = (year % 400 === 0) || (year % 100 !== 0 && year % 4 === 0);
    const daysInMonth = [31, isLeapYear ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    let dayOfYear = 0;
    for (let i = 0; i < month - 1; i++) {
        dayOfYear += daysInMonth[i];
    }
    dayOfYear += day;
    return dayOfYear;
};
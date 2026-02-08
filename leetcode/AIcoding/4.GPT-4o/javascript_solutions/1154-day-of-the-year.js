var dayOfYear = function(date) {
    const [year, month, day] = date.split('-').map(Number);
    const daysInMonth = [31, (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return day + daysInMonth.slice(0, month - 1).reduce((a, b) => a + b, 0);
};
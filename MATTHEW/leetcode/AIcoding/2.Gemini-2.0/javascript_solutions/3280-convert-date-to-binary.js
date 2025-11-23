var dayOfYear = function(date) {
    const [year, month, day] = date.split('-').map(Number);
    const isLeap = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
    const daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    let result = 0;
    for (let i = 1; i < month; i++) {
        result += daysInMonth[i];
    }
    result += day;
    if (isLeap && month > 2) {
        result++;
    }
    return result;
};
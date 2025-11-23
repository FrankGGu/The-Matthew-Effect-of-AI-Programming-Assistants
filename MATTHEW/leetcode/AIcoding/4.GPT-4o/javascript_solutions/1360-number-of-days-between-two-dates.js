var daysBetweenDates = function(date1, date2) {
    const dateObj1 = new Date(date1);
    const dateObj2 = new Date(date2);
    const millisecondsPerDay = 24 * 60 * 60 * 1000;
    return Math.abs((dateObj1 - dateObj2) / millisecondsPerDay);
};
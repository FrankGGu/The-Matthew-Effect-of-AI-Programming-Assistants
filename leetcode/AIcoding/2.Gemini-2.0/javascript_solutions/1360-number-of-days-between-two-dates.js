var daysBetweenDates = function(date1, date2) {
    const d1 = new Date(date1);
    const d2 = new Date(date2);

    const timeDiff = Math.abs(d2.getTime() - d1.getTime());

    return Math.ceil(timeDiff / (1000 * 3600 * 24));
};
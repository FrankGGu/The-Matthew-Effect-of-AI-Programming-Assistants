var dayOfTheWeek = function(day, month, year) {
    const daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    const date = new Date(year, month - 1, day);
    return daysOfWeek[date.getDay()];
};
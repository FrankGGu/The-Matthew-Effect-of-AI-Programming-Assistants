var dayOfTheWeek = function(day, month, year) {
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const zeller = (d, m, y) => {
        if (m < 3) {
            m += 12;
            y--;
        }
        return (d + Math.floor(13 * (m + 1) / 5) + y + Math.floor(y / 4) + Math.floor(y / 400) - Math.floor(y / 100)) % 7;
    };
    return days[zeller(day, month, year)];
};
var dateToBinary = function(date) {
    const [year, month, day] = date.split('-').map(Number);
    const yearBinary = year.toString(2).padStart(12, '0');
    const monthBinary = month.toString(2).padStart(4, '0');
    const dayBinary = day.toString(2).padStart(5, '0');
    return yearBinary + monthBinary + dayBinary;
};
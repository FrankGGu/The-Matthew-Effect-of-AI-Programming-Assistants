function convertDateToBinary(date) {
    const [year, month, day] = date.split('-').map(Number);
    const yearBin = year.toString(2).padStart(10, '0');
    const monthBin = month.toString(2).padStart(4, '0');
    const dayBin = day.toString(2).padStart(5, '0');
    return yearBin + monthBin + dayBin;
}
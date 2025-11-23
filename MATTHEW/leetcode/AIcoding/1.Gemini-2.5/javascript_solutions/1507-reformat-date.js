var reformatDate = function(date) {
    const parts = date.split(' ');
    const dayStr = parts[0];
    const monthStr = parts[1];
    const year = parts[2];

    const monthMap = {
        "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
        "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
        "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12"
    };

    const month = monthMap[monthStr];

    const day = parseInt(dayStr.slice(0, -2)).toString().padStart(2, '0');

    return `${year}-${month}-${day}`;
};
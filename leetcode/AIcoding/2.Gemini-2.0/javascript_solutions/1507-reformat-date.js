var reformatDate = function(date) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const parts = date.split(" ");
    const day = parts[0].slice(0, -2);
    const month = months.indexOf(parts[1]) + 1;
    const year = parts[2];

    const formattedMonth = month < 10 ? "0" + month : month;
    const formattedDay = day < 10 ? "0" + day : day;

    return `${year}-${formattedMonth}-${formattedDay}`;
};
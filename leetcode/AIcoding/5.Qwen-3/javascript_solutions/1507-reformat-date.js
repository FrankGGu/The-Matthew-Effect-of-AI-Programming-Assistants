function reformatDate(date) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const parts = date.split(' ');
    const day = parts[0].slice(0, -2);
    const month = months.indexOf(parts[1]) + 1;
    const year = parts[2];
    return `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
}
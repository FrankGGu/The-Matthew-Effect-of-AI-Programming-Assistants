var convertTime = function(current, correct) {
    const parseTime = (timeStr) => {
        const [hours, minutes] = timeStr.split(':').map(Number);
        return hours * 60 + minutes;
    };

    let diff = parseTime(correct) - parseTime(current);
    let operations = 0;

    operations += Math.floor(diff / 60);
    diff %= 60;

    operations += Math.floor(diff / 15);
    diff %= 15;

    operations += Math.floor(diff / 5);
    diff %= 5;

    operations += diff; // Remaining diff must be handled by 1-minute operations

    return operations;
};
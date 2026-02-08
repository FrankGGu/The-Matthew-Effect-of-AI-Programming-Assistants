var numberOfRounds = function(startTime, endTime) {
    let startHour = parseInt(startTime.substring(0, 2));
    let startMinute = parseInt(startTime.substring(3, 5));
    let endHour = parseInt(endTime.substring(0, 2));
    let endMinute = parseInt(endTime.substring(3, 5));

    let totalStartMinutes = startHour * 60 + startMinute;
    let totalEndMinutes = endHour * 60 + endMinute;

    if (totalEndMinutes < totalStartMinutes) {
        totalEndMinutes += 24 * 60; // endTime is on the next day
    }

    let firstRoundStart = Math.ceil(totalStartMinutes / 15) * 15;
    let lastRoundEnd = Math.floor(totalEndMinutes / 15) * 15;

    if (firstRoundStart >= lastRoundEnd) {
        return 0;
    }

    return (lastRoundEnd - firstRoundStart) / 15;
};
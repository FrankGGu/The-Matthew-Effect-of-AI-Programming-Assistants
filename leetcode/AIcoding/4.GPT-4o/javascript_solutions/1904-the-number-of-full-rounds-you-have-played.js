var numberOfRounds = function(startTime, finishTime) {
    const start = startTime.split(':').map(Number);
    const finish = finishTime.split(':').map(Number);

    let startMinutes = start[0] * 60 + start[1];
    let finishMinutes = finish[0] * 60 + finish[1];

    if (finishMinutes < startMinutes) {
        finishMinutes += 24 * 60;
    }

    startMinutes = Math.ceil(startMinutes / 15) * 15;
    finishMinutes = Math.floor(finishMinutes / 15) * 15;

    return Math.max(0, (finishMinutes - startMinutes) / 15);
};
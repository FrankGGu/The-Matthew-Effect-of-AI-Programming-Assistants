var numberOfRounds = function(startTime, finishTime) {
    const start = startTime.split(':').map(Number);
    const finish = finishTime.split(':').map(Number);

    const startMinutes = start[0] * 60 + start[1];
    const finishMinutes = finish[0] * 60 + finish[1];

    let diff = finishMinutes - startMinutes;

    if (diff < 0) {
        diff += 24 * 60;
    }

    const startRoundUp = Math.ceil(startMinutes / 15);
    const finishRoundDown = Math.floor(finishMinutes / 15);

    let startRoundedMinutes = startRoundUp * 15;
    let finishRoundedMinutes = finishRoundDown * 15;

    if (diff < 15) return 0;

    let rounds = 0;

    if (startRoundedMinutes > finishRoundedMinutes){
        rounds = Math.floor((24 * 60 - startRoundedMinutes + finishRoundedMinutes) / 15)
    }
    else{
       rounds = Math.floor((finishRoundedMinutes - startRoundedMinutes) / 15)
    }

    return rounds;
};
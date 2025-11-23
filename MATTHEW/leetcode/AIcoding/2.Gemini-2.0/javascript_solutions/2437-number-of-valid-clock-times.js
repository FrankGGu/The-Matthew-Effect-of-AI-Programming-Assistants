var countTime = function(time) {
    let count = 1;
    if (time[0] === '?') {
        if (time[1] === '?') {
            count *= 24;
        } else if (parseInt(time[1]) <= 3) {
            count *= 3;
        } else {
            count *= 2;
        }
    } else if (time[1] === '?') {
        if (parseInt(time[0]) === 0 || parseInt(time[0]) === 1) {
            count *= 10;
        } else {
            count *= 4;
        }
    }

    if (time[3] === '?') {
        count *= 6;
    }
    if (time[4] === '?') {
        count *= 10;
    }

    return count;
};
var maximumTime = function(time) {
    let result = "";
    if (time[0] === '?') {
        if (time[1] === '?' || parseInt(time[1]) <= 3) {
            result += '2';
        } else {
            result += '1';
        }
    } else {
        result += time[0];
    }

    if (time[1] === '?') {
        if (result[0] === '2') {
            result += '3';
        } else {
            result += '9';
        }
    } else {
        result += time[1];
    }

    result += ':';

    if (time[3] === '?') {
        result += '5';
    } else {
        result += time[3];
    }

    if (time[4] === '?') {
        result += '9';
    } else {
        result += time[4];
    }

    return result;
};
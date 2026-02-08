var fillMissingData = function(data) {
    let sum = 0;
    let count = 0;

    for (let i = 0; i < data.length; i++) {
        if (data[i] !== null) {
            sum += data[i];
            count++;
        }
    }

    let average = 0;
    if (count > 0) {
        average = sum / count;
    }

    for (let i = 0; i < data.length; i++) {
        if (data[i] === null) {
            data[i] = average;
        }
    }

    return data;
};
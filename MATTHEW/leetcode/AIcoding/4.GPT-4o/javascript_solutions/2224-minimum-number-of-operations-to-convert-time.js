var convertTime = function(current, correct) {
    const currentMinutes = parseInt(current.split(':')[0]) * 60 + parseInt(current.split(':')[1]);
    const correctMinutes = parseInt(correct.split(':')[0]) * 60 + parseInt(correct.split(':')[1]);
    let diff = correctMinutes - currentMinutes;
    const operations = [60, 15, 5, 1];
    let count = 0;

    for (let op of operations) {
        if (diff === 0) break;
        count += Math.floor(diff / op);
        diff %= op;
    }

    return count;
};
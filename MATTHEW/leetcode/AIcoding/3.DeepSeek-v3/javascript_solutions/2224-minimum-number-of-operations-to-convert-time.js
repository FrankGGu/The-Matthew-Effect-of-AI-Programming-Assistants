var convertTime = function(current, correct) {
    const parseTime = (time) => {
        const [h, m] = time.split(':').map(Number);
        return h * 60 + m;
    };

    const currentMinutes = parseTime(current);
    const correctMinutes = parseTime(correct);
    let diff = correctMinutes - currentMinutes;
    if (diff < 0) diff += 1440;

    let operations = 0;
    const steps = [60, 15, 5, 1];
    for (const step of steps) {
        operations += Math.floor(diff / step);
        diff %= step;
    }

    return operations;
};
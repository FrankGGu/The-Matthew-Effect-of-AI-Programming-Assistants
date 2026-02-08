var sampleStats = function(count) {
    let min = -1, max = -1, sum = 0, total = 0, mode = 0, maxCount = 0;
    for (let i = 0; i < count.length; i++) {
        if (count[i] > 0) {
            if (min === -1) min = i;
            max = i;
            sum += i * count[i];
            total += count[i];
            if (count[i] > maxCount) {
                maxCount = count[i];
                mode = i;
            }
        }
    }
    const mean = sum / total;

    let median = 0;
    let half = Math.floor(total / 2);
    let isEven = total % 2 === 0;
    let cnt = 0;
    let first = -1, second = -1;
    for (let i = 0; i < count.length; i++) {
        if (count[i] === 0) continue;
        cnt += count[i];
        if (first === -1 && cnt >= half) {
            first = i;
        }
        if (second === -1 && cnt >= half + 1) {
            second = i;
            break;
        }
    }
    median = isEven ? (first + second) / 2 : first;

    return [min, max, mean, median, mode];
};
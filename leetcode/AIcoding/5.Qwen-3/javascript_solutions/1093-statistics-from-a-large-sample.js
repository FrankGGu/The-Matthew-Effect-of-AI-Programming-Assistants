function sampleStats(sand) {
    let count = sand.length;
    let mean = 0;
    let sum = 0;
    let min = Infinity;
    let max = -Infinity;
    let mode = null;
    let modeCount = 0;
    let median = 0;
    let freq = {};

    for (let num of sand) {
        sum += num;
        min = Math.min(min, num);
        max = Math.max(max, num);

        if (freq[num] === undefined) {
            freq[num] = 1;
        } else {
            freq[num]++;
        }

        if (freq[num] > modeCount) {
            mode = num;
            modeCount = freq[num];
        }
    }

    mean = sum / count;

    sand.sort((a, b) => a - b);

    if (count % 2 === 1) {
        median = sand[Math.floor(count / 2)];
    } else {
        median = (sand[count / 2 - 1] + sand[count / 2]) / 2;
    }

    return [mean, min, max, median, mode];
}
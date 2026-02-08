var minimumDeviation = function(nums) {
    const set = new Set();
    let max = -Infinity;
    for (let num of nums) {
        if (num % 2 === 1) {
            num *= 2;
        }
        set.add(num);
        max = Math.max(max, num);
    }

    let minDeviation = Infinity;
    while (true) {
        const currentMax = Math.max(...set);
        const currentMin = Math.min(...set);
        minDeviation = Math.min(minDeviation, currentMax - currentMin);

        if (currentMax % 2 === 0) {
            set.delete(currentMax);
            set.add(currentMax / 2);
        } else {
            break;
        }
    }

    return minDeviation;
};
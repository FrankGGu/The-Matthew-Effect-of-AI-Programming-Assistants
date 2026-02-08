var sampleStats = function(count) {
    let min = Infinity;
    let max = -Infinity;
    let sum = 0;
    let total = 0;
    let mode = 0;
    let modeCount = 0;

    for (let i = 0; i < count.length; i++) {
        if (count[i] > 0) {
            min = Math.min(min, i);
            max = Math.max(max, i);
            sum += i * count[i];
            total += count[i];

            if (count[i] > modeCount) {
                modeCount = count[i];
                mode = i;
            }
        }
    }

    let mean = sum / total;

    let median;
    let mid = total / 2;
    let countSoFar = 0;
    let first = -1;
    let second = -1;

    for (let i = 0; i < count.length; i++) {
        if (count[i] > 0) {
            countSoFar += count[i];

            if (first === -1 && countSoFar >= mid) {
                first = i;
            }

            if (total % 2 === 0 && second === -1 && countSoFar >= mid + 1) {
                second = i;
                break;
            } else if (total % 2 !== 0 && first !== -1){
                second = first;
                break;
            }
        }
    }

    if (total % 2 === 0) {
        median = (first + second) / 2;
    } else {
        median = first;
    }

    return [min, max, mean, median, mode];
};
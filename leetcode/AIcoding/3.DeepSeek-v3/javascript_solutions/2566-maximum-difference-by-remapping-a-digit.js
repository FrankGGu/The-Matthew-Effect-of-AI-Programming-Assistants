var minMaxDifference = function(num) {
    const s = num.toString();
    let maxNum = -Infinity;
    let minNum = Infinity;

    for (let d = 0; d <= 9; d++) {
        const maxS = s.replace(new RegExp(d.toString(), 'g'), '9');
        const max = parseInt(maxS, 10);
        if (max > maxNum) {
            maxNum = max;
        }

        const minS = s.replace(new RegExp(d.toString(), 'g'), '0');
        const min = parseInt(minS, 10);
        if (min < minNum) {
            minNum = min;
        }
    }

    return maxNum - minNum;
};
var countExcellentPairs = function(nums, k) {
    const uniqueNums = Array.from(new Set(nums));
    const count = new Array(31).fill(0);

    for (let num of uniqueNums) {
        count[num.toString(2).split('').filter(x => x === '1').length]++;
    }

    let result = 0;
    for (let i = 0; i < count.length; i++) {
        if (count[i] > 0) {
            for (let j = 0; j < count.length; j++) {
                if (i + j >= k) {
                    result += count[i] * count[j];
                }
            }
        }
    }

    return result;
};
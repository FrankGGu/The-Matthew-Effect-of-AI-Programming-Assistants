var minimumSubtractableAmounts = function(nums) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    let steps = 0;
    while (true) {
        let max = -1;
        for (const [num, count] of freq.entries()) {
            if (count > 0) {
                max = Math.max(max, num);
            }
        }
        if (max === -1) break;

        for (const [num, count] of freq.entries()) {
            if (count > 0 && num === max) {
                freq.set(num, count - 1);
            }
        }
        steps++;
    }

    return steps;
};
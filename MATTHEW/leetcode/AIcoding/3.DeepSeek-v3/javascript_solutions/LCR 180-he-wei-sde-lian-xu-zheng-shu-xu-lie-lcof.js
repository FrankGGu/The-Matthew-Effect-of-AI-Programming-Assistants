var fileCombination = function(target) {
    let left = 1, right = 2;
    let sum = left + right;
    const result = [];

    while (left < right) {
        if (sum === target) {
            const temp = [];
            for (let i = left; i <= right; i++) {
                temp.push(i);
            }
            result.push(temp);
            sum -= left;
            left++;
        } else if (sum < target) {
            right++;
            sum += right;
        } else {
            sum -= left;
            left++;
        }
    }

    return result;
};
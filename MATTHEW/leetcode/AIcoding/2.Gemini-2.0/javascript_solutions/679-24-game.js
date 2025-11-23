var judgePoint24 = function(nums) {
    if (nums.length === 1) {
        return Math.abs(nums[0] - 24) < 1e-6;
    }

    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            const nextNums = [];
            for (let k = 0; k < nums.length; k++) {
                if (k !== i && k !== j) {
                    nextNums.push(nums[k]);
                }
            }

            const a = nums[i];
            const b = nums[j];

            nextNums.push(a + b);
            if (judgePoint24(nextNums)) return true;
            nextNums.pop();

            nextNums.push(a - b);
            if (judgePoint24(nextNums)) return true;
            nextNums.pop();

            nextNums.push(b - a);
            if (judgePoint24(nextNums)) return true;
            nextNums.pop();

            nextNums.push(a * b);
            if (judgePoint24(nextNums)) return true;
            nextNums.pop();

            if (b !== 0) {
                nextNums.push(a / b);
                if (judgePoint24(nextNums)) return true;
                nextNums.pop();
            }

            if (a !== 0) {
                nextNums.push(b / a);
                if (judgePoint24(nextNums)) return true;
                nextNums.pop();
            }
        }
    }

    return false;
};
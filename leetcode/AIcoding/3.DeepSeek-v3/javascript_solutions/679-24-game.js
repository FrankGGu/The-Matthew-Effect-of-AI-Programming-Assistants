var judgePoint24 = function(cards) {
    const EPSILON = 1e-6;

    function solve(nums) {
        if (nums.length === 1) {
            return Math.abs(nums[0] - 24) < EPSILON;
        }

        for (let i = 0; i < nums.length; i++) {
            for (let j = 0; j < nums.length; j++) {
                if (i === j) continue;

                const next = [];
                for (let k = 0; k < nums.length; k++) {
                    if (k !== i && k !== j) {
                        next.push(nums[k]);
                    }
                }

                for (let op = 0; op < 4; op++) {
                    if (op < 2 && i > j) continue;
                    if (op === 0) {
                        next.push(nums[i] + nums[j]);
                    } else if (op === 1) {
                        next.push(nums[i] * nums[j]);
                    } else if (op === 2) {
                        next.push(nums[i] - nums[j]);
                    } else if (op === 3) {
                        if (Math.abs(nums[j]) < EPSILON) continue;
                        next.push(nums[i] / nums[j]);
                    }

                    if (solve(next)) {
                        return true;
                    }
                    next.pop();
                }
            }
        }
        return false;
    }

    return solve(cards.map(num => num));
};
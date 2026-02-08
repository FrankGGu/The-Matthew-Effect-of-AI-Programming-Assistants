var recoverArray = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    for (let i = 1; i < n; i++) {
        if ((nums[i] - nums[0]) % 2 === 0) {
            const k = (nums[i] - nums[0]) / 2;
            if (k === 0) continue;
            const seen = new Map();
            let possible = true;
            const recovered = [];
            let j = 0;
            for (let l = 0; l < n; l++) {
                if (seen.get(nums[l]) > 0) {
                    seen.set(nums[l], seen.get(nums[l]) - 1);
                } else {
                    if (seen.has(nums[l] + 2 * k)) {
                        seen.set(nums[l] + 2 * k, (seen.get(nums[l] + 2 * k) || 0) + 1);
                    } else {
                        seen.set(nums[l] + 2 * k, 1);
                    }
                    recovered.push(nums[l] + k);
                }
            }
            if (recovered.length === n / 2) {
                return recovered;
            }
        }
    }
};
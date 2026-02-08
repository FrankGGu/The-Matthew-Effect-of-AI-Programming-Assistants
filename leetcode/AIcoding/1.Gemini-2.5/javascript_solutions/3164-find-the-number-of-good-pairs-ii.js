var numberOfGoodPairs = function(nums1, nums2, k) {
    let count = 0;
    const freq2 = {};

    for (const num of nums2) {
        freq2[num] = (freq2[num] || 0) + 1;
    }

    for (const num1_val of nums1) {
        if (num1_val % k !== 0) {
            continue;
        }

        const target_val = num1_val / k;

        for (let d = 1; d * d <= target_val; d++) {
            if (target_val % d === 0) {
                if (freq2[d]) {
                    count += freq2[d];
                }

                if (d * d !== target_val) {
                    const other_divisor = target_val / d;
                    if (freq2[other_divisor]) {
                        count += freq2[other_divisor];
                    }
                }
            }
        }
    }

    return count;
};
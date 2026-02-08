function minimumDifference(nums) {
    const total = nums.reduce((a, b) => a + b, 0);
    const n = nums.length;
    const half = Math.floor(n / 2);
    const sum1 = Array.from({ length: half + 1 }, () => new Set());
    const sum2 = Array.from({ length: n - half + 1 }, () => new Set());

    for (let mask = 0; mask < (1 << half); mask++) {
        let sum = 0;
        let count = 0;
        for (let j = 0; j < half; j++) {
            if (mask & (1 << j)) {
                sum += nums[j];
                count++;
            }
        }
        sum1[count].add(sum);
    }

    for (let mask = 0; mask < (1 << (n - half)); mask++) {
        let sum = 0;
        let count = 0;
        for (let j = 0; j < n - half; j++) {
            if (mask & (1 << j)) {
                sum += nums[half + j];
                count++;
            }
        }
        sum2[count].add(sum);
    }

    const possibleSums2 = Array.from({ length: n - half + 1 }, () => []);
    for (let i = 0; i <= n - half; i++) {
        possibleSums2[i] = Array.from(sum2[i]);
        possibleSums2[i].sort((a, b) => a - b);
    }

    let result = Infinity;

    for (let k = 0; k <= half; k++) {
        for (const sum1Value of sum1[k]) {
            const target = (total / 2) - sum1Value;
            let low = 0;
            let high = possibleSums2[n - half].length - 1;
            while (low <= high) {
                const mid = Math.floor((low + high) / 2);
                if (possibleSums2[n - half][mid] < target) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            if (low < possibleSums2[n - half].length) {
                result = Math.min(result, Math.abs(total - 2 * (sum1Value + possibleSums2[n - half][low])));
            }
            if (low > 0) {
                result = Math.min(result, Math.abs(total - 2 * (sum1Value + possibleSums2[n - half][low - 1])));
            }
        }
    }

    return result;
}
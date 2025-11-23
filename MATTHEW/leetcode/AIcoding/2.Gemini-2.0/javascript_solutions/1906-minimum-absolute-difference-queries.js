var minDifference = function(nums, queries) {
    const n = nums.length;
    const sortedIndices = Array(101).fill(null).map(() => []);

    for (let i = 0; i < n; i++) {
        sortedIndices[nums[i]].push(i);
    }

    const result = [];

    for (const [start, end] of queries) {
        let minDiff = Infinity;
        let prev = -1;

        for (let val = 1; val <= 100; val++) {
            const indices = sortedIndices[val];
            if (indices.length > 0) {
                let left = 0;
                let right = indices.length - 1;
                let closestIndex = -1;

                while (left <= right) {
                    const mid = Math.floor((left + right) / 2);
                    if (indices[mid] >= start) {
                        closestIndex = indices[mid];
                        right = mid - 1;
                    } else {
                        left = mid + 1;
                    }
                }

                if (closestIndex >= start && closestIndex <= end) {
                    if (prev !== -1) {
                        minDiff = Math.min(minDiff, val - prev);
                    }
                    prev = val;
                }
            }
        }

        if (minDiff === Infinity) {
            result.push(-1);
        } else {
            result.push(minDiff);
        }
    }

    return result;
};
var minimumDifference = function(nums) {
    const n = nums.length;
    const totalSum = nums.reduce((a, b) => a + b, 0);
    const half = n / 2;
    const sum1 = new Set();

    for (let i = 0; i <= half; i++) {
        const subsets = getSubsets(nums.slice(0, half), i);
        for (const subset of subsets) {
            sum1.add(subset.reduce((a, b) => a + b, 0));
        }
    }

    const sum2 = [];
    for (let i = 0; i <= half; i++) {
        const subsets = getSubsets(nums.slice(half), i);
        for (const subset of subsets) {
            sum2.push(subset.reduce((a, b) => a + b, 0));
        }
    }

    sum2.sort((a, b) => a - b);
    let minDiff = Infinity;

    for (const s1 of sum1) {
        const target = (totalSum / 2) - s1;
        const idx = binarySearch(sum2, target);
        if (idx < sum2.length) {
            minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * (s1 + sum2[idx])));
        }
        if (idx > 0) {
            minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * (s1 + sum2[idx - 1])));
        }
    }

    return minDiff;
};

function getSubsets(arr, k) {
    const subsets = [];
    const backtrack = (start, path) => {
        if (path.length === k) {
            subsets.push([...path]);
            return;
        }
        for (let i = start; i < arr.length; i++) {
            path.push(arr[i]);
            backtrack(i + 1, path);
            path.pop();
        }
    };
    backtrack(0, []);
    return subsets;
}

function binarySearch(arr, target) {
    let left = 0, right = arr.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}
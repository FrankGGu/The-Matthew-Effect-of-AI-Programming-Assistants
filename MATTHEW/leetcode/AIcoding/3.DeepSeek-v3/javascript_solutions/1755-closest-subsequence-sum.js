var minAbsDifference = function(nums, goal) {
    const n = nums.length;
    const half = Math.floor(n / 2);

    const left = nums.slice(0, half);
    const right = nums.slice(half);

    const leftSums = generateSums(left);
    const rightSums = generateSums(right);

    leftSums.sort((a, b) => a - b);
    rightSums.sort((a, b) => a - b);

    let minDiff = Infinity;

    for (const sum of leftSums) {
        const target = goal - sum;
        const closest = findClosest(rightSums, target);
        minDiff = Math.min(minDiff, Math.abs(target - closest));
        if (minDiff === 0) return 0;
    }

    return minDiff;
};

function generateSums(arr) {
    const sums = [0];
    for (const num of arr) {
        const temp = [];
        for (const sum of sums) {
            temp.push(sum + num);
        }
        sums.push(...temp);
    }
    return sums;
}

function findClosest(arr, target) {
    let left = 0;
    let right = arr.length - 1;
    let closest = arr[0];

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        closest = getCloser(closest, arr[mid], target);
        if (arr[mid] === target) {
            return target;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return closest;
}

function getCloser(a, b, target) {
    return Math.abs(a - target) < Math.abs(b - target) ? a : b;
}
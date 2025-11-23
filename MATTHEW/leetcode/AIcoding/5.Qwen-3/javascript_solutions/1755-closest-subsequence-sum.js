function minAbsoluteSumDiff(nums, target) {
    const n = nums.length;
    const sorted = [...nums].sort((a, b) => a - b);
    let minDiff = Infinity;

    for (let i = 0; i < n; i++) {
        const original = nums[i];
        const closest = findClosest(sorted, target - original);
        const diff = Math.abs(original + closest - target);
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    return minDiff;
}

function findClosest(arr, target) {
    let left = 0;
    let right = arr.length - 1;
    let closest = arr[0];

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const val = arr[mid];
        if (val === target) {
            return val;
        } else if (val < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    if (left < arr.length) {
        closest = arr[left];
    }
    if (right >= 0) {
        closest = Math.abs(arr[left] - target) < Math.abs(arr[right] - target) ? arr[left] : arr[right];
    }

    return closest;
}
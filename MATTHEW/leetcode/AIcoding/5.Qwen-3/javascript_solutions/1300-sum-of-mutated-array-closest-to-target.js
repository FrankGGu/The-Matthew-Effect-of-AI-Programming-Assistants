function findBestValue(nums, target) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }
    let left = 0, right = 100000;
    while (left < right) {
        let mid = (left + right) >> 1;
        let sum = 0;
        for (let i = 0; i < n; i++) {
            if (nums[i] > mid) {
                sum += mid;
                break;
            } else {
                sum += nums[i];
            }
        }
        if (sum < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    let res = left;
    let sum = 0;
    for (let i = 0; i < n; i++) {
        if (nums[i] > res) {
            sum += res;
            break;
        } else {
            sum += nums[i];
        }
    }
    return sum === target ? res : res - 1;
}
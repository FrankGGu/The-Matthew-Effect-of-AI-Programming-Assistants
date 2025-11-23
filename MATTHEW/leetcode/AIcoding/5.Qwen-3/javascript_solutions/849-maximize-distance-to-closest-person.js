function maxDistToClosest(nums) {
    let n = nums.length;
    let maxDist = 0;
    let left = 0;

    while (left < n && nums[left] === 0) {
        left++;
    }
    maxDist = left;

    let right = n - 1;
    while (right >= 0 && nums[right] === 0) {
        right--;
    }
    maxDist = Math.max(maxDist, n - 1 - right);

    let dist = 0;
    for (let i = left; i <= right; i++) {
        if (nums[i] === 1) {
            maxDist = Math.max(maxDist, dist);
            dist = 0;
        } else {
            dist++;
        }
    }

    return maxDist;
}
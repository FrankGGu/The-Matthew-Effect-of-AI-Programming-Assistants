var countIncremovableSubarrays = function(nums) {
    const n = nums.length;
    let left = 0;
    while (left < n - 1 && nums[left] < nums[left + 1]) {
        left++;
    }
    if (left === n - 1) {
        return n * (n + 1) / 2;
    }

    let right = n - 1;
    while (right > 0 && nums[right - 1] < nums[right]) {
        right--;
    }

    let res = (left + 2) * (n - right + 1);

    let i = 0, j = right;
    while (i <= left && j < n) {
        if (nums[i] < nums[j]) {
            res += n - j;
            i++;
        } else {
            j++;
        }
    }

    return res;
};
var getMinSwaps = function(num, k) {
    const nums = num.split('').map(Number);
    const original = [...nums];
    const n = nums.length;

    for (let i = 0; i < k; i++) {
        nextPermutation(nums);
    }

    let swaps = 0;
    for (let i = 0; i < n; i++) {
        if (original[i] === nums[i]) continue;
        let j = i + 1;
        while (j < n && original[j] !== nums[i]) {
            j++;
        }
        while (j > i) {
            [original[j], original[j - 1]] = [original[j - 1], original[j]];
            swaps++;
            j--;
        }
    }
    return swaps;
};

function nextPermutation(nums) {
    let i = nums.length - 2;
    while (i >= 0 && nums[i] >= nums[i + 1]) {
        i--;
    }
    if (i >= 0) {
        let j = nums.length - 1;
        while (j >= 0 && nums[j] <= nums[i]) {
            j--;
        }
        [nums[i], nums[j]] = [nums[j], nums[i]];
    }
    reverse(nums, i + 1);
}

function reverse(nums, start) {
    let i = start, j = nums.length - 1;
    while (i < j) {
        [nums[i], nums[j]] = [nums[j], nums[i]];
        i++;
        j--;
    }
}
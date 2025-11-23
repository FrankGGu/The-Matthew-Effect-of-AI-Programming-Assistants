var nextPermutation = function(nums) {
    const n = nums.length;

    const swap = (arr, i, j) => {
        [arr[i], arr[j]] = [arr[j], arr[i]];
    };

    const reverse = (arr, start, end) => {
        while (start < end) {
            swap(arr, start, end);
            start++;
            end--;
        }
    };

    let i = n - 2;
    while (i >= 0 && nums[i] >= nums[i + 1]) {
        i--;
    }

    if (i >= 0) {
        let j = n - 1;
        while (j >= 0 && nums[j] <= nums[i]) {
            j--;
        }
        swap(nums, i, j);
    }

    reverse(nums, i + 1, n - 1);
};
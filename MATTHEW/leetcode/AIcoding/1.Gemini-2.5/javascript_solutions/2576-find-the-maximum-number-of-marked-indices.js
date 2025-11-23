var maxNumOfMarkedIndices = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let count = 0;
    let i = 0;
    let j = Math.floor(n / 2);

    while (i < Math.floor(n / 2) && j < n) {
        if (2 * nums[i] <= nums[j]) {
            count++;
            i++;
            j++;
        } else {
            j++;
        }
    }

    return 2 * count;
};
var minOperations = function(nums, k) {
    let n = nums.length;
    let arr = [];
    for (let i = 0; i < n; i++) {
        if (nums[i] < k) {
            arr.push(nums[i]);
        }
    }

    arr.sort((a, b) => a - b);
    let count = 0;
    while (arr.length > 1) {
        let a = arr.shift();
        let b = arr.shift();
        arr.unshift(Math.min(a * 2, k));
        arr.sort((a, b) => a - b);
        count++;
    }

    if (arr.length === 1 && arr[0] < k) {
        count++;
    }

    return count;
};
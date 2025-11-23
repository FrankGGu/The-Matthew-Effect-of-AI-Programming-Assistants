var movesToMakeZigzag = function(nums) {
    const n = nums.length;
    let ans1 = 0;
    let ans2 = 0;

    const arr1 = nums.slice();
    const arr2 = nums.slice();

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            if (i > 0 && arr1[i] >= arr1[i - 1]) {
                ans1 += arr1[i] - arr1[i - 1] + 1;
                arr1[i] = arr1[i - 1] - 1;
            }
            if (i < n - 1 && arr1[i] >= arr1[i + 1]) {
                ans1 += arr1[i] - arr1[i + 1] + 1;
                arr1[i] = arr1[i + 1] - 1;
            }
        } else {
            if (i > 0 && arr2[i] >= arr2[i - 1]) {
                ans2 += arr2[i] - arr2[i - 1] + 1;
                arr2[i] = arr2[i - 1] - 1;
            }
            if (i < n - 1 && arr2[i] >= arr2[i + 1]) {
                ans2 += arr2[i] - arr2[i + 1] + 1;
                arr2[i] = arr2[i + 1] - 1;
            }
        }
    }

    return Math.min(ans1, ans2);
};
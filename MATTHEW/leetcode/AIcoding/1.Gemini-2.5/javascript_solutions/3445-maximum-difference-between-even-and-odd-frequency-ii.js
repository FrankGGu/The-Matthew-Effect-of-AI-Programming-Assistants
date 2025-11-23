var maxAbsoluteDifference = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    function findMaxMinSubarraySum(arr) {
        if (arr.length === 0) {
            return { maxSum: 0, minSum: 0 };
        }

        let currentMax = arr[0];
        let globalMax = arr[0];
        let currentMin = arr[0];
        let globalMin = arr[0];

        for (let i = 1; i < arr.length; i++) {
            currentMax = Math.max(arr[i], currentMax + arr[i]);
            globalMax = Math.max(globalMax, currentMax);

            currentMin = Math.min(arr[i], currentMin + arr[i]);
            globalMin = Math.min(globalMin, currentMin);
        }

        return { maxSum: globalMax, minSum: globalMin };
    }

    let transformedArr = new Array(nums.length);
    for (let i = 0; i < nums.length; i++) {
        transformedArr[i] = (nums[i] % 2 === 0) ? 1 : -1;
    }

    const { maxSum, minSum } = findMaxMinSubarraySum(transformedArr);

    return Math.max(Math.abs(maxSum), Math.abs(minSum));
};
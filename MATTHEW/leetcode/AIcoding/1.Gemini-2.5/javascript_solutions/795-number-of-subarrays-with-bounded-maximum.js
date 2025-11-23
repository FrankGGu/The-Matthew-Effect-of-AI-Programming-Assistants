var numSubarrayBoundedMax = function(nums, L, R) {
    function countSubarrays(arr, maxVal) {
        let count = 0;
        let currentLength = 0;
        for (let i = 0; i < arr.length; i++) {
            if (arr[i] <= maxVal) {
                currentLength++;
            } else {
                count += currentLength * (currentLength + 1) / 2;
                currentLength = 0;
            }
        }
        count += currentLength * (currentLength + 1) / 2;
        return count;
    }

    return countSubarrays(nums, R) - countSubarrays(nums, L - 1);
};
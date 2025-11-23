var numberOfSubarrays = function(nums, k) {
    let count = 0;
    let oddIndices = [-1];

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 2 !== 0) {
            oddIndices.push(i);
        }
    }

    oddIndices.push(nums.length);

    for (let i = 1; i < oddIndices.length - k; i++) {
        count += (oddIndices[i] - oddIndices[i - 1]) * (oddIndices[i + k] - oddIndices[i + k - 1]);
    }

    return count;
};
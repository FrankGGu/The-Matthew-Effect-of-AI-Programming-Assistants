var smallerNumbersThanCurrent = function(nums) {
    const maxVal = 100;
    const freq = new Array(maxVal + 1).fill(0);

    for (let i = 0; i < nums.length; i++) {
        freq[nums[i]]++;
    }

    const smallerCount = new Array(maxVal + 1).fill(0);
    for (let k = 1; k <= maxVal; k++) {
        smallerCount[k] = smallerCount[k - 1] + freq[k - 1];
    }

    const result = new Array(nums.length);
    for (let i = 0; i < nums.length; i++) {
        result[i] = smallerCount[nums[i]];
    }

    return result;
};
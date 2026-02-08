var longestSubarray = function(nums, limit) {
    let maxQueue = [];
    let minQueue = [];
    let left = 0;
    let right = 0;
    let maxLength = 0;

    while (right < nums.length) {
        while (maxQueue.length > 0 && nums[right] > maxQueue[maxQueue.length - 1]) {
            maxQueue.pop();
        }
        maxQueue.push(nums[right]);

        while (minQueue.length > 0 && nums[right] < minQueue[minQueue.length - 1]) {
            minQueue.pop();
        }
        minQueue.push(nums[right]);

        while (maxQueue[0] - minQueue[0] > limit) {
            if (nums[left] === maxQueue[0]) {
                maxQueue.shift();
            }
            if (nums[left] === minQueue[0]) {
                minQueue.shift();
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
};
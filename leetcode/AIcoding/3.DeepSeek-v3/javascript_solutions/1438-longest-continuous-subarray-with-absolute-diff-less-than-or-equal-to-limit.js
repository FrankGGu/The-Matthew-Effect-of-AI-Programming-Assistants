var longestSubarray = function(nums, limit) {
    let maxDeque = [];
    let minDeque = [];
    let left = 0;
    let result = 0;

    for (let right = 0; right < nums.length; right++) {
        while (maxDeque.length && nums[right] > maxDeque[maxDeque.length - 1]) {
            maxDeque.pop();
        }
        maxDeque.push(nums[right]);

        while (minDeque.length && nums[right] < minDeque[minDeque.length - 1]) {
            minDeque.pop();
        }
        minDeque.push(nums[right]);

        while (maxDeque[0] - minDeque[0] > limit) {
            if (maxDeque[0] === nums[left]) maxDeque.shift();
            if (minDeque[0] === nums[left]) minDeque.shift();
            left++;
        }

        result = Math.max(result, right - left + 1);
    }

    return result;
};
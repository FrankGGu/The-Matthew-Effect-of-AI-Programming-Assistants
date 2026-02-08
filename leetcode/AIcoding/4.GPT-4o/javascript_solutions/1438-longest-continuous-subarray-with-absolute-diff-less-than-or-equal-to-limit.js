var longestSubarray = function(nums, limit) {
    const maxDeque = [];
    const minDeque = [];
    let left = 0;
    let result = 0;

    for (let right = 0; right < nums.length; right++) {
        while (maxDeque.length && nums[maxDeque[maxDeque.length - 1]] <= nums[right]) {
            maxDeque.pop();
        }
        maxDeque.push(right);

        while (minDeque.length && nums[minDeque[minDeque.length - 1]] >= nums[right]) {
            minDeque.pop();
        }
        minDeque.push(right);

        while (nums[maxDeque[0]] - nums[minDeque[0]] > limit) {
            left++;
            if (maxDeque[0] < left) maxDeque.shift();
            if (minDeque[0] < left) minDeque.shift();
        }

        result = Math.max(result, right - left + 1);
    }

    return result;
};
function longestSubarray(nums, limit) {
    let left = 0;
    let maxLen = 0;
    const minDeque = [];
    const maxDeque = [];

    for (let right = 0; right < nums.length; right++) {
        while (minDeque.length > 0 && nums[right] < nums[minDeque[minDeque.length - 1]]) {
            minDeque.pop();
        }
        minDeque.push(right);

        while (maxDeque.length > 0 && nums[right] > nums[maxDeque[maxDeque.length - 1]]) {
            maxDeque.pop();
        }
        maxDeque.push(right);

        while (nums[maxDeque[0]] - nums[minDeque[0]] > limit) {
            if (minDeque[0] === left) {
                minDeque.shift();
            }
            if (maxDeque[0] === left) {
                maxDeque.shift();
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
}
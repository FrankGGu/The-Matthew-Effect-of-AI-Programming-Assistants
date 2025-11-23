var continuousSubarrays = function(nums) {
    let count = 0, left = 0;
    const n = nums.length;
    const minDeque = [];
    const maxDeque = [];

    for (let right = 0; right < n; right++) {
        while (minDeque.length && nums[minDeque[minDeque.length - 1]] >= nums[right]) minDeque.pop();
        while (maxDeque.length && nums[maxDeque[maxDeque.length - 1]] <= nums[right]) maxDeque.pop();

        minDeque.push(right);
        maxDeque.push(right);

        while (nums[maxDeque[0]] - nums[minDeque[0]] > 2) {
            left++;
            if (minDeque[0] < left) minDeque.shift();
            if (maxDeque[0] < left) maxDeque.shift();
        }

        count += right - left + 1;
    }

    return count;
};
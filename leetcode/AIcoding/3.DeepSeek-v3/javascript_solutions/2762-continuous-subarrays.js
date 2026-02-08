var continuousSubarrays = function(nums) {
    let res = 0;
    let left = 0;
    const minDeque = [];
    const maxDeque = [];

    for (let right = 0; right < nums.length; right++) {
        while (minDeque.length && nums[right] < nums[minDeque[minDeque.length - 1]]) {
            minDeque.pop();
        }
        minDeque.push(right);

        while (maxDeque.length && nums[right] > nums[maxDeque[maxDeque.length - 1]]) {
            maxDeque.pop();
        }
        maxDeque.push(right);

        while (nums[maxDeque[0]] - nums[minDeque[0]] > 2) {
            left++;
            if (minDeque[0] < left) minDeque.shift();
            if (maxDeque[0] < left) maxDeque.shift();
        }

        res += right - left + 1;
    }

    return res;
};
var countGood Subarrays = function(nums, k) {
    let count = 0, left = 0, right = 0, freq = new Map(), pairs = 0;

    while (right < nums.length) {
        let num = nums[right];
        freq.set(num, (freq.get(num) || 0) + 1);
        if (freq.get(num) === 2) pairs++;

        while (pairs > k) {
            let leftNum = nums[left];
            freq.set(leftNum, freq.get(leftNum) - 1);
            if (freq.get(leftNum) === 1) pairs--;
            left++;
        }

        count += right - left + 1;
        right++;
    }

    return count;
};
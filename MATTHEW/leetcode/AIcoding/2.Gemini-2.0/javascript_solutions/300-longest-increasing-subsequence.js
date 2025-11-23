var lengthOfLIS = function(nums) {
    const tails = [];

    for (const num of nums) {
        if (tails.length === 0 || num > tails[tails.length - 1]) {
            tails.push(num);
        } else {
            let left = 0;
            let right = tails.length - 1;

            while (left <= right) {
                const mid = Math.floor((left + right) / 2);
                if (tails[mid] < num) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            tails[left] = num;
        }
    }

    return tails.length;
};
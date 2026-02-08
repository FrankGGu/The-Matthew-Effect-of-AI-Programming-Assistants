var lengthOfLIS = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    let tails = [];

    for (let num of nums) {
        let i = 0;
        let j = tails.length;

        // Binary search to find the smallest tail that is greater than or equal to num
        while (i < j) {
            let mid = Math.floor((i + j) / 2);
            if (tails[mid] < num) {
                i = mid + 1;
            } else {
                j = mid;
            }
        }

        // If i reaches the end, it means num is greater than all existing tails,
        // so we extend the longest increasing subsequence by appending num.
        // Otherwise, we found a tail (at index i) that is greater than or equal to num.
        // We replace it with num to potentially allow for a longer subsequence later
        // (by having a smaller ending element for the same length subsequence).
        if (i === tails.length) {
            tails.push(num);
        } else {
            tails[i] = num;
        }
    }

    return tails.length;
};
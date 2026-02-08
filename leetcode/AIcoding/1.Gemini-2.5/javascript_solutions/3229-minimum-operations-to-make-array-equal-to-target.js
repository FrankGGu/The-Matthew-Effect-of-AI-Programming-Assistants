var minimumOperations = function(nums, target) {
    let ans = 0;
    let prevInc = 0; // Net amount that nums[i] was increased by operations at i-1
    let prevDec = 0; // Net amount that nums[i] was decreased by operations at i-1

    for (let i = 0; i < nums.length; i++) {
        const diff = target[i] - nums[i];

        if (diff > 0) { // nums[i] needs to increase
            // The amount nums[i] needs to increase is `diff`.
            // Some of this `diff` can be covered by `prevInc` (meaning nums[i] was already increased by `prevInc` from i-1 op).
            // The remaining `increaseNeeded` must be covered by a new operation at index `i`.
            const increaseNeeded = Math.max(0, diff - prevInc);
            ans += increaseNeeded;

            // This `increaseNeeded` amount is added to nums[i] by an operation at index `i`.
            // This operation also subtracts `increaseNeeded` from nums[i+1].
            // So, for the next iteration (i+1), `prevDec` will be `increaseNeeded`.
            prevDec = increaseNeeded;

            // `prevInc` is reduced by `diff`. If `diff` is larger than `prevInc`, it becomes 0.
            prevInc = Math.max(0, prevInc - diff);
        } else if (diff < 0) { // nums[i] needs to decrease
            // The amount nums[i] needs to decrease is `abs(diff)`.
            // Some of this `abs(diff)` can be covered by `prevDec` (meaning nums[i] was already decreased by `prevDec` from i-1 op).
            // The remaining `decreaseNeeded` must be covered by a new operation at index `i-1`.
            const decreaseNeeded = Math.max(0, Math.abs(diff) - prevDec);
            ans += decreaseNeeded;

            // This `decreaseNeeded` amount is subtracted from nums[i] by an operation at index `i-1`.
            // This operation also adds `decreaseNeeded` to nums[i].
            // So, for the next iteration (i+1), `prevInc` will be `decreaseNeeded`.
            prevInc = decreaseNeeded;

            // `prevDec` is reduced by `abs(diff)`. If `abs(diff)` is larger than `prevDec`, it becomes 0.
            prevDec = Math.max(0, prevDec - Math.abs(diff));
        } else { // diff === 0
            // If nums[i] is already equal to target[i], no new operations are needed at this index.
            // The carry-over effects for the next element should be reset.
            prevInc = 0;
            prevDec = 0;
        }
    }

    return ans;
};
var waysToSplitArray = function(nums) {
    const MOD = 10**9 + 7;
    const ones_indices = [];

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            ones_indices.push(i);
        }
    }

    if (ones_indices.length === 0) {
        return 0;
    }

    let result = 1;
    for (let j = 0; j < ones_indices.length - 1; j++) {
        const p_j = ones_indices[j];
        const p_next = ones_indices[j+1];

        // For two consecutive '1's at indices p_j and p_next,
        // we can either split the array between them or keep them in the same subarray.
        // The number of positions to place a split point between p_j and p_next (exclusive of p_next)
        // is (p_next - p_j). This covers all ways to split them into two distinct subarrays.
        // For example, if p_j=0, p_next=3 ([1,0,0,1]), (3-0)=3 ways to split:
        // [1]|[0,0,1], [1,0]|[0,1], [1,0,0]|[1].
        // Additionally, we have one option to not split them, meaning they belong to the same subarray:
        // [1,0,0,1].
        // So, the total number of ways for this segment is (p_next - p_j) + 1.
        const ways_for_this_segment = (p_next - p_j); 
        result = (result * ways_for_this_segment) % MOD;
    }

    return result;
};
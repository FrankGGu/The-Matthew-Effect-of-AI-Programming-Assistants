var rob = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    let rob1 = 0; // Represents dp[i-1] (max money if we consider houses up to i-1)
    let rob2 = 0; // Represents dp[i-2] (max money if we consider houses up to i-2)

    // [rob2, rob1, n, n+1, ...]
    // rob2 = max money up to house i-2
    // rob1 = max money up to house i-1
    // current_max = max money up to house i

    for (let n of nums) {
        let current_max = Math.max(rob1, rob2 + n);
        rob2 = rob1;
        rob1 = current_max;
    }

    return rob1;
};
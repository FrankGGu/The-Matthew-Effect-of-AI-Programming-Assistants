var minCost = function(s1, s2, x) {
    let diffCount = 0;
    for (let i = 0; i < s1.length; i++) {
        if (s1[i] !== s2[i]) {
            diffCount++;
        }
    }

    if (diffCount === 0) {
        return 0;
    }

    // Operation 1: Choose two indices i, j (s1[i]!=s2[i], s1[j]!=s2[j], i!=j), flip s1[i] and s1[j]. Cost x. (Fixes 2 differences)
    // Operation 2: Choose one index i (s1[i]!=s2[i]), flip s1[i]. Cost 1. (Fixes 1 difference)

    // We want to minimize the total cost.
    // Let num_op1 be the number of Operation 1s, and num_op2 be the number of Operation 2s.
    // We need to fix diffCount differences in total: 2 * num_op1 + num_op2 = diffCount.
    // Total cost = num_op1 * x + num_op2 * 1.

    // Substitute num_op2 = diffCount - 2 * num_op1 into the cost equation:
    // Cost = num_op1 * x + (diffCount - 2 * num_op1)
    // Cost = num_op1 * (x - 2) + diffCount

    // To minimize Cost, we analyze the term (x - 2):

    // Case 1: x >= 2 (i.e., x - 2 >= 0)
    // In this case, (x - 2) is non-negative. To minimize the cost, we should minimize num_op1.
    // The minimum possible value for num_op1 is 0.
    // If num_op1 = 0, then num_op2 = diffCount.
    // Cost = 0 * x + diffCount * 1 = diffCount.
    // This means it's always cheaper or equal to use Operation 2 for every difference, as two Operation 2s (cost 2) are better or equal to one Operation 1 (cost x).
    if (x >= 2) {
        return diffCount;
    }

    // Case 2: x < 2 (i.e., x - 2 < 0)
    // In this case, (x - 2) is negative. To minimize the cost, we should maximize num_op1.
    // The maximum possible value for num_op1 is floor(diffCount / 2).
    // This is possible because Operation 1 can be applied to any two differing indices, regardless of their position.

    // If diffCount is even:
    // We can use num_op1 = diffCount / 2 Operation 1s.
    // Then num_op2 = diffCount - 2 * (diffCount / 2) = 0.
    // Cost = (diffCount / 2) * x + 0 * 1 = (diffCount / 2) * x.
    if (diffCount % 2 === 0) {
        return (diffCount / 2) * x;
    } else {
        // If diffCount is odd:
        // We can use num_op1 = (diffCount - 1) / 2 Operation 1s.
        // This leaves 1 difference remaining.
        // Then num_op2 = diffCount - 2 * ((diffCount - 1) / 2) = diffCount - (diffCount - 1) = 1.
        // Cost = ((diffCount - 1) / 2) * x + 1 * 1 = ((diffCount - 1) / 2) * x + 1.
        return ((diffCount - 1) / 2) * x + 1;
    }
};
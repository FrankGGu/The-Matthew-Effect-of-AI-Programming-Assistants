var bestRotation = function(nums) {
    const n = nums.length;
    const diff = new Array(n).fill(0);

    // For each element nums[i], determine the range of k values for which it contributes a point.
    // An element nums[i] (original index i) is at index j after k rotations.
    // j = (i - k + n) % n.
    // It contributes a point if nums[i] > j.
    // So, we need nums[i] > (i - k + n) % n.

    // nums[i] starts contributing a point when its new index j becomes nums[i] - 1.
    // (i - k + n) % n = nums[i] - 1
    // This happens when k = (i - (nums[i] - 1) + n) % n = (i - nums[i] + 1 + n) % n.
    // Let this be k_start_point. At this k, the score increases.
    // So, diff[k_start_point]++.

    // nums[i] stops contributing a point when its new index j becomes 0, and then wraps around to n-1.
    // More precisely, it stops contributing when its new index j becomes nums[i].
    // (i - k + n) % n = nums[i]
    // This happens when k = (i - nums[i] + n) % n.
    // Let this be k_end_point. At this k, the score decreases.
    // So, diff[k_end_point]--.

    for (let i = 0; i < n; i++) {
        // If nums[i] is 0, it can never be greater than its index (which is non-negative).
        // So it never contributes a point.
        if (nums[i] === 0) {
            continue;
        }

        const val = nums[i];

        // k_start_point: The rotation k where nums[i] moves to index `val - 1` (and starts scoring).
        // k_start_point = (i - (val - 1) + n) % n = (i - val + 1 + n) % n.
        // This is the k where the score increases.
        const kStart = (i - val + 1 + n) % n;
        diff[kStart]++;

        // k_end_point: The rotation k where nums[i] moves to index `val` (and stops scoring).
        // k_end_point = (i - val + n) % n.
        // This is the k where the score decreases.
        const kEnd = (i - val + n) % n;
        diff[kEnd]--;
    }

    let currentScore = 0;
    // Calculate initial score for k=0.
    // B[j] = nums[(j+0)%n] = nums[j].
    // Score if nums[j] > j.
    for (let i = 0; i < n; i++) {
        if (nums[i] > i) {
            currentScore++;
        }
    }

    let maxScore = currentScore;
    let resultK = 0;

    // Calculate scores for k = 1 to n-1 using the difference array.
    // score[k] = score[k-1] + diff[k].
    for (let k = 1; k < n; k++) {
        currentScore += diff[k];
        if (currentScore > maxScore) {
            maxScore = currentScore;
            resultK = k;
        }
    }

    return resultK;
};
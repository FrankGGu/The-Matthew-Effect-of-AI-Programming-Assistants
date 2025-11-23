function maximumMultiplicationScore(nums1, nums2) {
    let maxScore = -Infinity;
    for (let i = 0; i < nums1.length; i++) {
        let score = 0;
        for (let j = 0; j < nums2.length; j++) {
            score += nums1[i] * nums2[j];
        }
        if (score > maxScore) {
            maxScore = score;
        }
    }
    return maxScore;
}
var minimumTotalCost = function(nums1, nums2) {
    let n = nums1.length;
    let cost = 0;
    let freq = new Map();
    let mostFreq = 0;
    let mostFreqNum = -1;
    let commonIndices = 0;

    for (let i = 0; i < n; i++) {
        if (nums1[i] === nums2[i]) {
            cost += i;
            commonIndices++;
            freq.set(nums1[i], (freq.get(nums1[i]) || 0) + 1);
            if (freq.get(nums1[i]) > mostFreq) {
                mostFreq = freq.get(nums1[i]);
                mostFreqNum = nums1[i];
            }
        }
    }

    if (mostFreq <= Math.floor(commonIndices / 2)) {
        return cost;
    }

    let extraIndicesNeeded = mostFreq - Math.floor(commonIndices / 2);
    let extraCost = 0;
    for (let i = 0; i < n && extraIndicesNeeded > 0; i++) {
        if (nums1[i] !== nums2[i] && nums1[i] !== mostFreqNum && nums2[i] !== mostFreqNum) {
            extraCost += i;
            extraIndicesNeeded--;
        }
    }

    if (extraIndicesNeeded > 0) {
        return -1;
    }

    return cost + extraCost;
};
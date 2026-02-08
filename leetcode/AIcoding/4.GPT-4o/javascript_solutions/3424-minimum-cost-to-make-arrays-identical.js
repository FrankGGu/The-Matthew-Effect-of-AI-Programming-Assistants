var minCost = function(nums1, nums2, cost) {
    let n = nums1.length;
    let prefixSum = new Array(n + 1).fill(0);
    let totalCost = 0;
    let totalCount = 0;

    for (let i = 0; i < n; i++) {
        prefixSum[nums1[i]] += cost[i];
        totalCost += cost[i];
        totalCount++;
    }

    let minCost = Infinity;
    let currentCost = 0;

    for (let i = 1; i <= 100; i++) {
        currentCost += prefixSum[i];
        let targetCost = totalCost - currentCost;
        minCost = Math.min(minCost, targetCost + currentCost);
    }

    return minCost;
};
function numSubarraysWithMoreOnesThanZeros(nums) {
    const MOD = 1000000007;
    let n = nums.length;
    let prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + (nums[i] === 1 ? 1 : -1);
    }

    function countSubarrays(start, end, target) {
        if (start > end) return 0;
        if (start === end) return prefix[start] > target ? 1 : 0;

        let mid = Math.floor((start + end) / 2);
        let leftCount = countSubarrays(start, mid, target);
        let rightCount = countSubarrays(mid + 1, end, target);

        let crossCount = 0;
        let j = mid + 1;
        for (let i = start; i <= mid; i++) {
            while (j <= end && prefix[j] - prefix[i] <= target) {
                j++;
            }
            crossCount += (end - j + 1);
        }

        return (leftCount + rightCount + crossCount) % MOD;
    }

    return countSubarrays(0, n, 0);
}
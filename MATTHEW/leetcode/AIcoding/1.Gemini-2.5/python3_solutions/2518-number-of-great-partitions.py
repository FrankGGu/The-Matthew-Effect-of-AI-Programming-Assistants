class Solution:
    def countGreatPartitions(self, nums: list[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        total_sum = sum(nums)

        if total_sum < 2 * k:
            return 0

        dp = [0] * (total_sum + 1)
        dp[0] = 1

        for num in nums:
            for s in range(total_sum, num - 1, -1):
                dp[s] = (dp[s] + dp[s - num]) % MOD

        total_partitions = pow(2, n, MOD)

        invalid_partitions_count = 0

        # Count partitions where sum(nums1) < k
        for s in range(k):
            invalid_partitions_count = (invalid_partitions_count + dp[s]) % MOD

        # Count partitions where sum(nums2) < k (which means sum(nums1) > total_sum - k)
        # These are sums in the range [total_sum - k + 1, total_sum]
        for s in range(total_sum - k + 1, total_sum + 1):
            invalid_partitions_count = (invalid_partitions_count + dp[s]) % MOD

        # Apply inclusion-exclusion: subtract partitions counted twice
        # These are partitions where sum(nums1) < k AND sum(nums2) < k
        # This means sum(nums1) is in the range [total_sum - k + 1, k - 1]
        start_overlap = max(0, total_sum - k + 1)
        end_overlap = k - 1

        if start_overlap <= end_overlap:
            for s in range(start_overlap, end_overlap + 1):
                invalid_partitions_count = (invalid_partitions_count - dp[s] + MOD) % MOD

        result = (total_partitions - invalid_partitions_count + MOD) % MOD

        return result
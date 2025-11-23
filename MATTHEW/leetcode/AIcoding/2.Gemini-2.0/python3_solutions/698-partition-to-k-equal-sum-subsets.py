class Solution:
    def canPartitionKSubsets(self, nums: List[int], k: int) -> bool:
        total_sum = sum(nums)
        if total_sum % k != 0:
            return False

        target_sum = total_sum // k
        nums.sort(reverse=True)

        if nums[0] > target_sum:
            return False

        buckets = [0] * k

        def backtrack(index):
            if index == len(nums):
                return all(bucket == target_sum for bucket in buckets)

            for i in range(k):
                if buckets[i] + nums[index] <= target_sum:
                    buckets[i] += nums[index]
                    if backtrack(index + 1):
                        return True
                    buckets[i] -= nums[index]

                    if buckets[i] == 0:
                        break

            return False

        return backtrack(0)
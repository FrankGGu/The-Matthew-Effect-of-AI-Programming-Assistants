class Solution:
    def canPartitionKSubsets(self, nums: List[int], k: int) -> bool:
        total = sum(nums)
        if total % k != 0:
            return False
        target = total // k
        nums.sort(reverse=True)
        used = [False] * len(nums)

        def backtrack(start, k_left, current_sum):
            if k_left == 0:
                return True
            if current_sum == target:
                return backtrack(0, k_left - 1, 0)
            for i in range(start, len(nums)):
                if not used[i] and current_sum + nums[i] <= target:
                    used[i] = True
                    if backtrack(i + 1, k_left, current_sum + nums[i]):
                        return True
                    used[i] = False
            return False

        return backtrack(0, k, 0)
class Solution:
    def maximumANDSum(self, nums: List[int], numSlots: int) -> int:
        n = len(nums)
        mask_max = 3 ** numSlots
        dp = [-1] * mask_max
        dp[0] = 0

        for mask in range(mask_max):
            if dp[mask] == -1:
                continue
            current = mask
            slot_used = [0] * numSlots
            for i in range(numSlots):
                slot_used[i] = current % 3
                current = current // 3
            total = sum(slot_used)
            if total >= n:
                continue
            for i in range(numSlots):
                if slot_used[i] < 2:
                    new_mask = mask + (3 ** i)
                    val = dp[mask] + (nums[total] & (i + 1))
                    if val > dp[new_mask]:
                        dp[new_mask] = val
        return max(dp)
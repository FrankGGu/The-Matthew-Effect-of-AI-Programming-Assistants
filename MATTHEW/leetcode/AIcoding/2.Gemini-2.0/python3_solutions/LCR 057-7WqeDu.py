class Solution:
    def containsNearbyAlmostDuplicate(self, nums: list[int], k: int, t: int) -> bool:
        if k < 1 or t < 0:
            return False
        d = {}
        for i, num in enumerate(nums):
            bucket = num // (t + 1) if t != -1 else num
            if bucket in d:
                return True
            if bucket - 1 in d and abs(num - d[bucket - 1]) <= t:
                return True
            if bucket + 1 in d and abs(num - d[bucket + 1]) <= t:
                return True
            d[bucket] = num
            if len(d) > k:
                old_bucket = nums[i - k] // (t + 1) if t != -1 else nums[i-k]
                del d[old_bucket]
        return False
class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], k: int, t: int) -> bool:
        if k < 1 or t < 0:
            return False
        d = {}
        for i in range(len(nums)):
            bucket = nums[i] // (t + 1) if t != 0 else nums[i]
            if bucket in d:
                return True
            if bucket - 1 in d and abs(nums[i] - d[bucket - 1]) <= t:
                return True
            if bucket + 1 in d and abs(nums[i] - d[bucket + 1]) <= t:
                return True
            d[bucket] = nums[i]
            if i >= k:
                del d[nums[i - k] // (t + 1) if t != 0 else nums[i - k]]
        return False
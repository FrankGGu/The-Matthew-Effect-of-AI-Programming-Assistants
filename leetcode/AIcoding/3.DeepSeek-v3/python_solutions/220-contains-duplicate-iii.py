class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], k: int, t: int) -> bool:
        if t < 0 or k <= 0:
            return False
        buckets = {}
        for i, num in enumerate(nums):
            bucket = num // (t + 1)
            if bucket in buckets:
                return True
            if bucket - 1 in buckets and abs(num - buckets[bucket - 1]) <= t:
                return True
            if bucket + 1 in buckets and abs(num - buckets[bucket + 1]) <= t:
                return True
            buckets[bucket] = num
            if i >= k:
                del buckets[nums[i - k] // (t + 1)]
        return False
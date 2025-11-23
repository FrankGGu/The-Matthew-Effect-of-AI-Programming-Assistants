class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], k: int, t: int) -> bool:
        if t < 0 or k <= 0:
            return False
        buckets = {}
        for i, num in enumerate(nums):
            bucket_id = num // (t + 1)
            if bucket_id in buckets:
                return True
            if bucket_id - 1 in buckets and abs(num - buckets[bucket_id - 1]) <= t:
                return True
            if bucket_id + 1 in buckets and abs(num - buckets[bucket_id + 1]) <= t:
                return True
            buckets[bucket_id] = num
            if i >= k:
                del buckets[nums[i - k] // (t + 1)]
        return False
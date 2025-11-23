class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], k: int, t: int) -> bool:
        from collections import OrderedDict

        if t < 0 or k < 0:
            return False

        bucket_size = t + 1
        buckets = {}

        for i, num in enumerate(nums):
            bucket_id = num // bucket_size

            if bucket_id in buckets:
                return True

            if (bucket_id - 1) in buckets and abs(num - buckets[bucket_id - 1]) <= t:
                return True

            if (bucket_id + 1) in buckets and abs(num - buckets[bucket_id + 1]) <= t:
                return True

            buckets[bucket_id] = num

            if len(buckets) > k:
                del buckets[nums[i - k] // bucket_size]

        return False
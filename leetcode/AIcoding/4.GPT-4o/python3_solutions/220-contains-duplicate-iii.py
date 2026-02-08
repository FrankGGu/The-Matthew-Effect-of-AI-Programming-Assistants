class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], k: int, t: int) -> bool:
        if k <= 0 or t < 0:
            return False

        buckets = {}
        width = t + 1

        for i in range(len(nums)):
            bucket_id = nums[i] // width

            if bucket_id in buckets:
                return True

            if bucket_id - 1 in buckets and abs(nums[i] - buckets[bucket_id - 1]) <= t:
                return True

            if bucket_id + 1 in buckets and abs(nums[i] - buckets[bucket_id + 1]) <= t:
                return True

            buckets[bucket_id] = nums[i]

            if i >= k:
                del buckets[nums[i - k] // width]

        return False
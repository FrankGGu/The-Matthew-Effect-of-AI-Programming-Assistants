class Solution:
    def containsNearbyAlmostDuplicate(self, nums: list[int], k: int, t: int) -> bool:
        buckets = {}
        width = t + 1 

        for i, num in enumerate(nums):
            bucket_id = num // width

            # Check current bucket
            if bucket_id in buckets:
                return True

            # Check adjacent buckets
            # Left adjacent bucket
            if (bucket_id - 1) in buckets and abs(num - buckets[bucket_id - 1]) <= t:
                return True

            # Right adjacent bucket
            if (bucket_id + 1) in buckets and abs(num - buckets[bucket_id + 1]) <= t:
                return True

            # Add current number to buckets
            buckets[bucket_id] = num

            # Remove element that falls out of the window
            if i >= k:
                old_num = nums[i - k]
                old_bucket_id = old_num // width
                del buckets[old_bucket_id]

        return False
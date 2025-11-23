class Solution:
    def containsNearbyAlmostDuplicate(self, nums: list[int], k: int, t: int) -> bool:
        if k < 0 or t < 0:
            return False

        # The size of each bucket. If t is 0, bucket_size is 1, meaning each number
        # gets its own bucket. If t > 0, numbers in the same bucket have a difference
        # of at most t.
        bucket_size = t + 1 

        # Dictionary to store numbers in the current window.
        # Key: bucket_id, Value: a number in that bucket.
        # We only need to store one number per bucket, as any number in the bucket
        # can be used to check the condition.
        buckets = {}

        for i, num in enumerate(nums):
            # Calculate the bucket ID for the current number.
            # Python's floor division `//` handles negative numbers correctly for this purpose.
            bucket_id = num // bucket_size

            # Check the current bucket.
            # If a number already exists in this bucket, their absolute difference
            # must be <= t (because the bucket size is t+1).
            if bucket_id in buckets:
                return True

            # Check adjacent buckets (bucket_id - 1 and bucket_id + 1).
            # Numbers in adjacent buckets might also satisfy the condition |num - x| <= t.
            # Check bucket_id - 1
            if (bucket_id - 1) in buckets and abs(num - buckets[bucket_id - 1]) <= t:
                return True

            # Check bucket_id + 1
            if (bucket_id + 1) in buckets and abs(num - buckets[bucket_id + 1]) <= t:
                return True

            # Add the current number to its bucket.
            # If there's already a number in this bucket, it gets overwritten.
            # This is fine because we only need to know if *any* number exists there.
            buckets[bucket_id] = num

            # Maintain the sliding window of size k.
            # If the window has exceeded size k, remove the oldest element.
            if i >= k:
                # Calculate the bucket ID for the number leaving the window.
                old_num = nums[i - k]
                old_bucket_id = old_num // bucket_size
                # Remove it from the buckets dictionary.
                # It's possible that old_bucket_id was already overwritten by a new number
                # in the same bucket, but that's fine. If the key exists, delete it.
                if old_bucket_id in buckets: # Check if it still exists before deleting
                    del buckets[old_bucket_id]

        return False
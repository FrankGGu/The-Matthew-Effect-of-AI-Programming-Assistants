import random

class Solution:
    def findKthLargest(self, nums: list[int], k: int) -> int:
        n = len(nums)
        target_idx = n - k

        def quickselect(left, right):
            if left == right:
                return nums[left]

            pivot_idx = random.randint(left, right)
            pivot_value = nums[pivot_idx]

            nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]

            store_idx = left
            for i in range(left, right):
                if nums[i] < pivot_value:
                    nums[store_idx], nums[i] = nums[i], nums[store_idx]
                    store_idx += 1

            nums[right], nums[store_idx] = nums[store_idx], nums[right]

            if store_idx == target_idx:
                return nums[store_idx]
            elif store_idx < target_idx:
                return quickselect(store_idx + 1, right)
            else:
                return quickselect(left, store_idx - 1)

        return quickselect(0, n - 1)
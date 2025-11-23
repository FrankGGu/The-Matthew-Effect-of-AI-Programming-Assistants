class Solution:
    def nextGreaterElement(self, n: int) -> int:
        nums = list(str(n))
        length = len(nums)

        # Step 1: Find the first decreasing element from the right
        i = length - 2
        while i >= 0 and nums[i] >= nums[i + 1]:
            i -= 1

        if i == -1:
            return -1

        # Step 2: Find the element just larger than nums[i]
        j = length - 1
        while nums[j] <= nums[i]:
            j -= 1

        # Step 3: Swap elements
        nums[i], nums[j] = nums[j], nums[i]

        # Step 4: Reverse the elements to the right of i
        nums[i + 1:] = reversed(nums[i + 1:])

        result = int(''.join(nums))
        return result if result < 2**31 else -1
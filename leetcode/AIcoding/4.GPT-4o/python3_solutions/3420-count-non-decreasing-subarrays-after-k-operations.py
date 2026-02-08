class Solution:
    def countNonDecreasing(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = 0

        def valid_len(start):
            length = 1
            for i in range(start, n - 1):
                if nums[i + 1] >= nums[i]:
                    length += 1
                else:
                    break
            return length

        for i in range(n):
            if i > 0 and nums[i] < nums[i - 1]:
                continue

            length = valid_len(i)
            count += length

            for j in range(i, min(i + length, n)):
                if j + k < n:
                    if nums[j] + k < nums[j + 1]:
                        count += 1
                else:
                    count += 1

        return count
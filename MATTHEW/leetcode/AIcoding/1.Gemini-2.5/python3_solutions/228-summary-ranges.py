class Solution:
    def summaryRanges(self, nums: list[int]) -> list[str]:
        if not nums:
            return []

        result = []
        n = len(nums)
        i = 0

        while i < n:
            start = nums[i]
            j = i

            # Find the end of the current contiguous range
            while j + 1 < n and nums[j+1] == nums[j] + 1:
                j += 1

            end = nums[j]

            # Add the range to the result list
            if start == end:
                result.append(str(start))
            else:
                result.append(f"{start}->{end}")

            # Move to the next unvisited number
            i = j + 1

        return result
class Solution:
    def smallestArray(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        if k >= n:
            return sorted(nums)

        result = nums[:]
        for i in range(n):
            min_index = i
            for j in range(i + 1, min(i + k + 1, n)):
                if result[j] < result[min_index]:
                    min_index = j
            if min_index != i:
                result[i], result[min_index] = result[min_index], result[i]
                k -= (min_index - i)
                if k <= 0:
                    break
        return result
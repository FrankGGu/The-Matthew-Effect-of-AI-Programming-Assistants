class Solution:
    def smallestSubarrays(self, nums: list[int]) -> list[int]:
        n = len(nums)
        ans = [0] * n

        last_occurrence = [-1] * 30 

        for i in range(n - 1, -1, -1):
            current_max_j = i

            for bit in range(30):
                if (nums[i] >> bit) & 1:
                    last_occurrence[bit] = i

                if last_occurrence[bit] != -1:
                    current_max_j = max(current_max_j, last_occurrence[bit])

            ans[i] = current_max_j - i + 1

        return ans
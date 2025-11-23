class Solution:
    def waysToMakeFair(self, nums: List[int]) -> int:
        n = len(nums)
        prefix_odd = [0] * (n + 1)
        prefix_even = [0] * (n + 1)

        for i in range(n):
            if i % 2 == 0:
                prefix_even[i+1] = prefix_even[i] + nums[i]
                prefix_odd[i+1] = prefix_odd[i]
            else:
                prefix_odd[i+1] = prefix_odd[i] + nums[i]
                prefix_even[i+1] = prefix_even[i]

        res = 0
        for i in range(n):
            even_sum = prefix_even[i] + (prefix_odd[n] - prefix_odd[i+1])
            odd_sum = prefix_odd[i] + (prefix_even[n] - prefix_even[i+1])
            if even_sum == odd_sum:
                res += 1

        return res
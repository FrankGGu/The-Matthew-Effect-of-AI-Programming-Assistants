class Solution:
    def maxFrequencyScore(self, nums: List[int], k: int) -> int:
        nums.sort()
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        left = 0
        max_freq = 0

        for right in range(n):
            median = nums[(left + right) // 2]
            cost = median * ((right - left + 1) // 2) - (prefix[(left + right) // 2 + 1] - prefix[left]) 
            cost += (prefix[right + 1] - prefix[(left + right) // 2 + 1]) - median * ((right - left) // 2)

            while cost > k:
                left += 1
                median = nums[(left + right) // 2]
                cost = median * ((right - left + 1) // 2) - (prefix[(left + right) // 2 + 1] - prefix[left]) 
                cost += (prefix[right + 1] - prefix[(left + right) // 2 + 1]) - median * ((right - left) // 2)

            max_freq = max(max_freq, right - left + 1)

        return max_freq
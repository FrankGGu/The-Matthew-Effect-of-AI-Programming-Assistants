def solve():
    n, k = map(int, input().split())
    nums = list(map(int, input().split()))

    prefix_sums = [0] * (n + 1)
    for i in range(n):
        prefix_sums[i + 1] = (prefix_sums[i] + nums[i]) % k

    max_sum = 0
    for length in range(1, n + 1):
        for i in range(n - length + 1):
            j = i + length
            current_sum = sum(nums[i:j])
            if current_sum % k == 0:
                max_sum = max(max_sum, current_sum)

    print(max_sum)

def maxSubarraySumDivisibleByK(nums, k):
    n = len(nums)
    prefix_sums = [0] * (n + 1)
    for i in range(n):
        prefix_sums[i + 1] = (prefix_sums[i] + nums[i]) % k

    first_occurrence = {}
    max_len = 0
    for i in range(n + 1):
        if prefix_sums[i] not in first_occurrence:
            first_occurrence[prefix_sums[i]] = i
        else:
            max_len = max(max_len, i - first_occurrence[prefix_sums[i]])

    max_sum = 0
    for length in range(1, n + 1):
        for i in range(n - length + 1):
            j = i + length
            current_sum = sum(nums[i:j])
            if current_sum % k == 0:
                max_sum = max(max_sum, current_sum)

    if max_len == 0 and 0 not in nums:
      return 0

    if max_len == n:
        return sum(nums)

    max_sum = 0
    for length in range(1, n + 1):
        for i in range(n - length + 1):
            subarray = nums[i:i+length]
            if sum(subarray) % k == 0:
                max_sum = max(max_sum, sum(subarray))

    return max_sum

class Solution:
    def maxSubarraySumDivisibleByK(self, nums: List[int], k: int) -> int:
        return maxSubarraySumDivisibleByK(nums, k)
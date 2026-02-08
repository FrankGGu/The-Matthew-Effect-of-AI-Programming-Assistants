from collections import defaultdict

class Solution:
    def minOperations(self, nums: list[int], target: int) -> int:
        if sum(nums) < target:
            return -1

        counts = defaultdict(int)
        for num in nums:
            counts[num.bit_length() - 1] += 1

        ans = 0
        curr_sum = 0
        for i in range(32):
            if target & (1 << i):
                if counts[i] > 0:
                    counts[i] -= 1
                    curr_sum += (1 << i)
                else:
                    j = i + 1
                    while j < 32 and counts[j] == 0:
                        j += 1
                    if j == 32:
                        return -1
                    counts[j] -= 1
                    ans += (j - i)
                    for k in range(i, j):
                        counts[k] += 1
                    curr_sum += (1 << i)

            counts[i + 1] += counts[i] // 2

        return ans
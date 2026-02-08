class Solution:
    def minPartitions(self, s: str, k: int) -> int:
        count = 1
        curr_sum = 0
        for digit in s:
            val = int(digit)
            if val > k:
                return -1
            if curr_sum * 10 + val <= k:
                curr_sum = curr_sum * 10 + val
            else:
                count += 1
                curr_sum = val
        return max(int(digit) for digit in s)
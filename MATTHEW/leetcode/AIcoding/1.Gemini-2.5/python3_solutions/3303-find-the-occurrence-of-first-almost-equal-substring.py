class Solution:
    def findTheOccurrenceOfFirstAlmostEqualSubstring(self, s: str, t: str, k: int) -> int:
        n = len(s)

        costs = [0] * n
        for i in range(n):
            costs[i] = abs(ord(s[i]) - ord(t[i]))

        max_len = 0
        current_cost_sum = 0
        left = 0
        for right in range(n):
            current_cost_sum += costs[right]
            while current_cost_sum > k:
                current_cost_sum -= costs[left]
                left += 1
            max_len = max(max_len, right - left + 1)

        if max_len == 0:
            return -1

        current_cost_sum = 0
        for i in range(max_len):
            current_cost_sum += costs[i]

        if current_cost_sum <= k:
            return 0

        for i in range(1, n - max_len + 1):
            current_cost_sum = current_cost_sum - costs[i-1] + costs[i + max_len - 1]
            if current_cost_sum <= k:
                return i

        return -1
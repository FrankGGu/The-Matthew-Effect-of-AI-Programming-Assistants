class Solution:
    def equalSubstring(self, s: str, t: str, max_cost: int) -> int:
        n = len(s)
        max_len = 0
        left = 0
        current_cost = 0

        for right in range(n):
            current_cost += abs(ord(s[right]) - ord(t[right]))

            while current_cost > max_cost:
                current_cost -= abs(ord(s[left]) - ord(t[left]))
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len
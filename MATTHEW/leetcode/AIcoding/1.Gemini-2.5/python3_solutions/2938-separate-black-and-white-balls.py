class Solution:
    def minimumSwaps(self, s: str) -> int:
        ans = 0
        ones_count = 0
        for char in s:
            if char == '1':
                ones_count += 1
            else:  # char == '0'
                ans += ones_count
        return ans
class Solution:
    def beautySum(self, s: str) -> int:
        total_beauty = 0
        n = len(s)

        for i in range(n):
            freq = [0] * 26
            max_freq = 0
            min_freq = float('inf')

            for j in range(i, n):
                idx = ord(s[j]) - ord('a')
                freq[idx] += 1
                max_freq = max(max_freq, freq[idx])
                min_freq = min(min_freq, freq[idx] or float('inf'))

                if min_freq != float('inf'):
                    total_beauty += max_freq - min_freq

        return total_beauty
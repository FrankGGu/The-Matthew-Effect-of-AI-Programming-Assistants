class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        def count_valid_substrings(start, end):
            count = 0
            freq = {}
            for i in range(start, end + 1):
                freq[s[i]] = freq.get(s[i], 0) + 1
                while len(freq) > k:
                    freq[s[start]] -= 1
                    if freq[s[start]] == 0:
                        del freq[s[start]]
                    start += 1
                count += end - start + 1
            return count

        total_count = 0
        n = len(s)
        for i in range(n):
            total_count += count_valid_substrings(i, n - 1)
        return total_count
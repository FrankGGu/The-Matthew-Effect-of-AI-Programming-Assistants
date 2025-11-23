class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        ans = 0

        for i in range(n):
            freq = [0] * 26
            total_unique_chars = 0
            chars_with_k_freq = 0

            for j in range(i, n):
                char_idx = ord(s[j]) - ord('a')

                old_freq = freq[char_idx]
                freq[char_idx] += 1
                new_freq = freq[char_idx]

                if old_freq == 0:
                    total_unique_chars += 1

                if old_freq < k and new_freq == k:
                    chars_with_k_freq += 1

                if total_unique_chars == chars_with_k_freq:
                    ans += 1

        return ans
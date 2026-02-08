import collections

class Solution:
    def minAnagramLength(self, s: str) -> int:
        n = len(s)
        for k in range(1, n + 1):
            if n % k == 0:
                first_block_counter = collections.Counter(s[:k])
                is_valid_k = True
                for i in range(1, n // k):
                    current_block_counter = collections.Counter(s[i * k : (i + 1) * k])
                    if current_block_counter != first_block_counter:
                        is_valid_k = False
                        break
                if is_valid_k:
                    return k
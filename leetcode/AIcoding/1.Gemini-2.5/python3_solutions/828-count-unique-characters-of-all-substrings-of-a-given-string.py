from collections import defaultdict

class Solution:
    def uniqueLetterString(self, s: str) -> int:
        n = len(s)
        char_indices = defaultdict(list)
        for i, char in enumerate(s):
            char_indices[char].append(i)

        total_sum = 0
        MOD = 10**9 + 7

        for indices_list in char_indices.values():
            indices_list.insert(0, -1)
            indices_list.append(n)

            for p in range(1, len(indices_list) - 1):
                current_idx = indices_list[p]
                prev_idx = indices_list[p-1]
                next_idx = indices_list[p+1]

                contribution = (current_idx - prev_idx) * (next_idx - current_idx)
                total_sum = (total_sum + contribution) % MOD

        return total_sum
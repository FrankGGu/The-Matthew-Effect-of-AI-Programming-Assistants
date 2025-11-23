class Solution:
    def canMakePaliQueries(self, s: str, queries: list[list[int]]) -> list[bool]:
        n = len(s)
        prefix_xor = [0] * (n + 1)

        for i in range(n):
            char_idx = ord(s[i]) - ord('a')
            prefix_xor[i+1] = prefix_xor[i] ^ (1 << char_idx)

        results = []
        for left, right, k in queries:
            sub_mask = prefix_xor[right + 1] ^ prefix_xor[left]

            odd_counts = 0
            for i in range(26):
                if (sub_mask >> i) & 1:
                    odd_counts += 1

            changes_needed = odd_counts // 2
            results.append(changes_needed <= k)

        return results
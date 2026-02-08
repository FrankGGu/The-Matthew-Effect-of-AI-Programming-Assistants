class Solution:
    def longestAwesome(self, s: str) -> int:
        n = len(s)
        prefix_mask = [0] * (n + 1)
        for i in range(n):
            prefix_mask[i + 1] = prefix_mask[i] ^ (1 << int(s[i]))

        first_seen = {0: 0}
        max_len = 0
        for i in range(1, n + 1):
            if prefix_mask[i] not in first_seen:
                first_seen[prefix_mask[i]] = i

            max_len = max(max_len, i - first_seen[prefix_mask[i]])

            for j in range(10):
                mask_to_check = prefix_mask[i] ^ (1 << j)
                if mask_to_check in first_seen:
                    max_len = max(max_len, i - first_seen[mask_to_check])

        return max_len
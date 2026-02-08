class Solution:
    def maxRepOpt1(self, text: str) -> int:
        from collections import defaultdict

        char_indices = defaultdict(list)
        for i, c in enumerate(text):
            char_indices[c].append(i)

        max_len = 0

        for c in char_indices:
            indices = char_indices[c]
            current_len = 1
            max_current = 1
            total = len(indices)

            for i in range(1, len(indices)):
                if indices[i] == indices[i-1] + 1:
                    current_len += 1
                else:
                    gap = indices[i] - indices[i-1] - 1
                    if gap == 1:
                        current_len = 1 + (indices[i-1] - (indices[i-2] if i >= 2 else -1) - 1 if i >= 2 else 0) + 1
                    else:
                        current_len = 1
                max_current = max(max_current, current_len)

            max_len = max(max_len, max_current + (1 if total > max_current else 0))

        return max_len
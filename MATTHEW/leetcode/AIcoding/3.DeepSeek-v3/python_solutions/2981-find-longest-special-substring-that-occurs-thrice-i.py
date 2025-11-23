class Solution:
    def maximumLength(self, s: str) -> int:
        from collections import defaultdict

        freq = defaultdict(list)
        n = len(s)
        if n < 3:
            return -1

        current_char = s[0]
        count = 1
        for i in range(1, n):
            if s[i] == current_char:
                count += 1
            else:
                freq[current_char].append(count)
                current_char = s[i]
                count = 1
        freq[current_char].append(count)

        max_len = -1
        for char in freq:
            lst = freq[char]
            lst.sort(reverse=True)
            if len(lst) >= 3:
                max_len = max(max_len, lst[2])
            if len(lst) >= 2:
                if lst[0] >= 3:
                    max_len = max(max_len, lst[0] - 2)
                if lst[1] >= 2:
                    max_len = max(max_len, min(lst[0] - 1, lst[1]))
            if lst[0] >= 3:
                max_len = max(max_len, lst[0] - 2)
        return max_len if max_len != 0 else -1
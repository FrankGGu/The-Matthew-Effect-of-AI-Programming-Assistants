class Solution:
    def maximumLength(self, s: str) -> int:
        from collections import defaultdict

        groups = defaultdict(list)
        current_char = s[0]
        count = 1

        for c in s[1:]:
            if c == current_char:
                count += 1
            else:
                groups[current_char].append(count)
                current_char = c
                count = 1
        groups[current_char].append(count)

        max_len = -1

        for char in groups:
            lst = sorted(groups[char], reverse=True)
            lst.extend([0, 0])

            a, b, c = lst[0], lst[1], lst[2]

            candidate1 = a - 2
            candidate2 = min(a - 1, b)
            candidate3 = c

            current_max = max(candidate1, candidate2, candidate3)

            if current_max > max_len:
                max_len = current_max

        return max_len if max_len != 0 else -1
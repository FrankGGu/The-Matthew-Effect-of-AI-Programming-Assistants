class Solution:
    def minimumOperations(self, num: str) -> int:
        n = len(num)
        min_deletions = n

        targets = ["00", "25", "50", "75"]

        for target_suffix in targets:
            d1_char = target_suffix[0]
            d2_char = target_suffix[1]

            idx_d2 = -1
            for i in range(n - 1, -1, -1):
                if num[i] == d2_char:
                    idx_d2 = i
                    break

            if idx_d2 == -1:
                continue

            idx_d1 = -1
            for i in range(idx_d2 - 1, -1, -1):
                if num[i] == d1_char:
                    idx_d1 = i
                    break

            if idx_d1 == -1:
                continue

            current_deletions = (n - 1 - idx_d2) + (idx_d2 - idx_d1 - 1)
            min_deletions = min(min_deletions, current_deletions)

        if '0' in num:
            min_deletions = min(min_deletions, n - 1)

        return min_deletions
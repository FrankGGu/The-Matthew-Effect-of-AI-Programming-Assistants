class Solution:
    def minimumChanges(self, s: str, k: int) -> int:
        n = len(s)
        ones_count = s.count('1')

        remainder = ones_count % k

        if remainder == 0:
            return 0

        changes_to_decrease = remainder

        changes_to_increase = k - remainder

        if ones_count + changes_to_increase <= n:
            return min(changes_to_decrease, changes_to_increase)
        else:
            return changes_to_decrease
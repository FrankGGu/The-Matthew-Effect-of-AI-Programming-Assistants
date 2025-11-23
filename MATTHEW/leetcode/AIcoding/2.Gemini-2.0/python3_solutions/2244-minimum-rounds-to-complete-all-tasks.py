from collections import Counter

class Solution:
    def minimumRounds(self, tasks: list[int]) -> int:
        counts = Counter(tasks)
        rounds = 0
        for count in counts.values():
            if count == 1:
                return -1
            elif count % 3 == 0:
                rounds += count // 3
            else:
                rounds += count // 3 + 1
        return rounds
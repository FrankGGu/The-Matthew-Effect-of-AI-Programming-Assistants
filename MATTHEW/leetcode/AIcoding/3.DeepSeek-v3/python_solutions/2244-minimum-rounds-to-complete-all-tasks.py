from collections import defaultdict

class Solution:
    def minimumRounds(self, tasks: List[int]) -> int:
        freq = defaultdict(int)
        for task in tasks:
            freq[task] += 1

        rounds = 0
        for count in freq.values():
            if count == 1:
                return -1
            rounds += (count + 2) // 3

        return rounds
class Solution:
    def numRabbits(self, answers: List[str]) -> int:
        from collections import Counter

        count = Counter()
        total = 0

        for ans in answers:
            if count[ans] == 0:
                total += int(ans) + 1
                count[ans] = int(ans)
            else:
                count[ans] -= 1

        return total
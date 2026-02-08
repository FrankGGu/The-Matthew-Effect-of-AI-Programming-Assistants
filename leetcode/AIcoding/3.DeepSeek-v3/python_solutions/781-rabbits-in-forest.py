class Solution:
    def numRabbits(self, answers: List[int]) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        for num in answers:
            count[num] += 1
        res = 0
        for num, cnt in count.items():
            res += (cnt + num) // (num + 1) * (num + 1)
        return res
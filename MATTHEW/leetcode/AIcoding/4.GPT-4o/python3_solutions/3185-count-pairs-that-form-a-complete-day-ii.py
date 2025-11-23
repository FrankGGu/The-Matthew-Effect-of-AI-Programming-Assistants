class Solution:
    def countPairs(self, n: int, day: List[int]) -> int:
        count = 0
        freq = [0] * 366
        for d in day:
            count += freq[(d - 1) % 365]
            freq[d % 365] += 1
        return count
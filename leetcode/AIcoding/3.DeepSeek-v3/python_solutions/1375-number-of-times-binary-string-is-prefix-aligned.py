class Solution:
    def numTimesAllBlue(self, flips: List[int]) -> int:
        max_seen = 0
        count = 0
        for i in range(len(flips)):
            max_seen = max(max_seen, flips[i])
            if max_seen == i + 1:
                count += 1
        return count
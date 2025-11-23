class Solution:
    def numPairsDivisibleBy60(self, time: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        result = 0

        for t in time:
            mod = t % 60
            complement = (60 - mod) % 60
            result += count[complement]
            count[mod] += 1

        return result
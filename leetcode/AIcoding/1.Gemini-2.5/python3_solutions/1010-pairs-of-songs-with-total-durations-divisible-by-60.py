class Solution:
    def numPairsDivisibleBy60(self, time: list[int]) -> int:
        remainders = [0] * 60
        count = 0
        for t in time:
            remainder = t % 60

            complement_remainder = (60 - remainder) % 60

            count += remainders[complement_remainder]
            remainders[remainder] += 1

        return count
class Solution:
    def maximumBags(self, capacity: List[int], rocks: List[int], additionalRocks: int) -> int:
        diff = []
        for i in range(len(capacity)):
            diff.append(capacity[i] - rocks[i])

        diff.sort()

        count = 0
        for d in diff:
            if additionalRocks >= d:
                additionalRocks -= d
                count += 1
            else:
                break

        return count
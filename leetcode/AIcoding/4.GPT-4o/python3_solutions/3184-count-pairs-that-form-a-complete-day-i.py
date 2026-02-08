class Solution:
    def countPairs(self, days: List[int]) -> int:
        count = 0
        freq = {}

        for day in days:
            if day in freq:
                count += freq[day]
                freq[day] += 1
            else:
                freq[day] = 1

        return count
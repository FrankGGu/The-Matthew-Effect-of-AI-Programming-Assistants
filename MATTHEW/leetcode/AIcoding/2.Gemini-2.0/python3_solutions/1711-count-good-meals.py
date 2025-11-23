class Solution:
    def countGoodMeals(self, deliciousness: List[int]) -> int:
        count = 0
        freq = {}
        for d in deliciousness:
            for i in range(22):
                power_of_two = 1 << i
                if power_of_two - d in freq:
                    count += freq[power_of_two - d]
            if d in freq:
                freq[d] += 1
            else:
                freq[d] = 1
        return count % (10**9 + 7)
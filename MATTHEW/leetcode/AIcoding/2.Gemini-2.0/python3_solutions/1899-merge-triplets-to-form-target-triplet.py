class Solution:
    def mergeTriplets(self, triplets: List[List[int]], target: List[int]) -> bool:
        good = set()
        for t in triplets:
            if t[0] <= target[0] and t[1] <= target[1] and t[2] <= target[2]:
                if t[0] == target[0]:
                    good.add(0)
                if t[1] == target[1]:
                    good.add(1)
                if t[2] == target[2]:
                    good.add(2)
        return len(good) == 3
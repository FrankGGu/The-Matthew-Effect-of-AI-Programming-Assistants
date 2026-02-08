class Solution:
    def mergeTriplets(self, triplets: List[List[int]], target: List[int]) -> bool:
        a, b, c = target
        x = y = z = 0
        for t in triplets:
            if t[0] <= a and t[1] <= b and t[2] <= c:
                x = max(x, t[0])
                y = max(y, t[1])
                z = max(z, t[2])
        return [x, y, z] == target
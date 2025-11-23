class Solution:
    def flipgame(self, fronts: List[int], backs: List[int]) -> int:
        same = set()
        for i in range(len(fronts)):
            if fronts[i] == backs[i]:
                same.add(fronts[i])

        ans = float('inf')
        for x in fronts:
            if x not in same:
                ans = min(ans, x)
        for x in backs:
            if x not in same:
                ans = min(ans, x)

        return ans if ans != float('inf') else 0
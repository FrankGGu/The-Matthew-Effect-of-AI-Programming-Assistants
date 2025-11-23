class Solution:
    def minimizeTheDifference(self, mat: List[List[int]], target: int) -> int:
        s = {0}
        for row in mat:
            new_s = set()
            for x in s:
                for num in row:
                    new_s.add(x + num)
            s = new_s
        return min(abs(x - target) for x in s)
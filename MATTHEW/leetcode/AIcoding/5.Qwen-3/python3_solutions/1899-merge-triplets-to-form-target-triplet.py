class Solution:
    def canForm(self, triplets: List[List[int]], target: List[int]) -> bool:
        a, b, c = target
        for t in triplets:
            if t[0] > a or t[1] > b or t[2] > c:
                continue
            if t[0] == a and t[1] == b and t[2] == c:
                return True
        return False
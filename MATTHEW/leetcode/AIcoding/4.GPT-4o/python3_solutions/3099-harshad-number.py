class Solution:
    def isHarshad(self, x: int) -> bool:
        return x % sum(int(d) for d in str(x)) == 0
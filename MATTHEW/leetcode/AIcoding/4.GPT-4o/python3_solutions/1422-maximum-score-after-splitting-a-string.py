class Solution:
    def maximumScore(self, s: str) -> int:
        count_a = s.count('a')
        count_b = s.count('b')
        count_c = s.count('c')
        return (count_b + count_c) + (count_a + count_c)
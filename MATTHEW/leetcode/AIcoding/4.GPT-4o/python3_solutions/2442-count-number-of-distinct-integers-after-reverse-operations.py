class Solution:
    def countDistinctIntegers(self, n: int) -> int:
        distinct_integers = set()
        for i in range(n):
            distinct_integers.add(i)
            reversed_i = int(str(i)[::-1])
            distinct_integers.add(reversed_i)
        return len(distinct_integers)
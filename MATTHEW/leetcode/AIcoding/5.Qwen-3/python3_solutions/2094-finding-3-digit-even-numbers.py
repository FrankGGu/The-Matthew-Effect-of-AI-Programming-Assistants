class Solution:
    def findEvenNumbers(self, digits: List[int]) -> List[int]:
        from itertools import permutations

        result = set()
        for p in permutations(digits, 3):
            num = p[0] * 100 + p[1] * 10 + p[2]
            if num % 2 == 0 and p[0] != 0:
                result.add(num)
        return sorted(result)
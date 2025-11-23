def findSneakyNumbers(n):
    sneaky_numbers = []
    for i in range(1, n + 1):
        if '1' not in str(i) and '2' not in str(i):
            sneaky_numbers.append(i)
    return sneaky_numbers[-2:]

class Solution:
    def twoSneakyNumbers(self, n: int) -> List[int]:
        return findSneakyNumbers(n)
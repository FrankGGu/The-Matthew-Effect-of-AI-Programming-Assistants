class Solution:
    def stableBinaryArrays(self, n: int) -> List[List[int]]:
        from itertools import product

        def isStable(arr):
            for i in range(len(arr) - 1):
                if arr[i] == arr[i + 1] == 1:
                    return False
            return True

        result = []
        for bits in product([0, 1], repeat=n):
            if isStable(bits):
                result.append(list(bits))
        return result
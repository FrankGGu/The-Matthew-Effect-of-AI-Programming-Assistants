from typing import List

class Solution:
    def commonPrefixes(self, A: List[int], B: List[int]) -> List[int]:
        n = len(A)
        result = []
        setA = set()
        setB = set()
        for i in range(n):
            setA.add(A[i])
            setB.add(B[i])
            common = setA & setB
            result.append(len(common))
        return result
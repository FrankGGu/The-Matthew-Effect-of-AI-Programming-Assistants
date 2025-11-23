class Solution:
    def addToArrayForm(self, A: List[int], K: int) -> List[int]:
        A = ''.join(map(str, A))
        result = str(int(A) + K)
        return [int(digit) for digit in result]
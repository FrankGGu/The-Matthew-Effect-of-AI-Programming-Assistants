class Solution:
    def comfortableTemperature(self, A: List[int]) -> int:
        count = 0
        for i in range(len(A)):
            for j in range(i + 1, len(A)):
                if abs(A[i] - A[j]) <= 5:
                    count += 1
        return count
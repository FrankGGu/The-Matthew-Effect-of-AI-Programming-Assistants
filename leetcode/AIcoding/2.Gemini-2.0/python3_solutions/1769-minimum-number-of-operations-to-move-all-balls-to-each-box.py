class Solution:
    def minOperations(self, boxes: str) -> list[int]:
        n = len(boxes)
        result = [0] * n
        for i in range(n):
            for j in range(n):
                if boxes[j] == '1':
                    result[i] += abs(i - j)
        return result
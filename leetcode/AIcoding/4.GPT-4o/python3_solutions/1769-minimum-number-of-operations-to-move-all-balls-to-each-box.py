class Solution:
    def minOperations(self, boxes: str) -> List[int]:
        n = len(boxes)
        left_operations = [0] * n
        right_operations = [0] * n

        for i in range(1, n):
            left_operations[i] = left_operations[i - 1] + boxes[i - 1] == '1'

        for i in range(n - 2, -1, -1):
            right_operations[i] = right_operations[i + 1] + boxes[i + 1] == '1'

        return [left_operations[i] + right_operations[i] for i in range(n)]
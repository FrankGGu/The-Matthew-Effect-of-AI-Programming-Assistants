class Solution:
    def minOperations(self, boxes: str) -> List[int]:
        n = len(boxes)
        res = [0] * n
        left = 0
        count = 0
        for i in range(n):
            res[i] += left
            left += count
            if boxes[i] == '1':
                count += 1
        right = 0
        count = 0
        for i in range(n - 1, -1, -1):
            res[i] += right
            right += count
            if boxes[i] == '1':
                count += 1
        return res
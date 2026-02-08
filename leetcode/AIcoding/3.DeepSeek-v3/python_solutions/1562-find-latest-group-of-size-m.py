class Solution:
    def findLatestStep(self, arr: List[int], m: int) -> int:
        n = len(arr)
        if m == n:
            return n
        length = [0] * (n + 2)
        res = -1
        for i in range(n):
            pos = arr[i]
            left = length[pos - 1]
            right = length[pos + 1]
            total = left + right + 1
            length[pos - left] = total
            length[pos + right] = total
            if left == m or right == m:
                res = i
        return res
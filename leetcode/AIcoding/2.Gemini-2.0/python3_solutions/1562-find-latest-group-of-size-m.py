class Solution:
    def findLatestStep(self, arr: List[int], m: int) -> int:
        n = len(arr)
        length = [0] * (n + 2)
        count = [0] * (n + 1)
        ans = -1
        for i, a in enumerate(arr):
            left = length[a - 1]
            right = length[a + 1]
            length[a - left] = length[a + right] = left + right + 1
            count[left] -= 1
            count[right] -= 1
            count[left + right + 1] += 1
            if count[m] > 0:
                ans = i + 1
        return ans
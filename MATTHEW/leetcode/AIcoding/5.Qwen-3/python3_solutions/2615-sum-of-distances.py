class Solution:
    def sumDistance(self, nums: List[int], s: str, d: int) -> List[int]:
        n = len(nums)
        arr = []
        for i in range(n):
            pos = nums[i] + (ord(s[i]) - ord('A')) * d
            arr.append((pos, i))
        arr.sort()
        res = [0] * n
        for i in range(n):
            res[arr[i][1]] = arr[i][0]
        return res
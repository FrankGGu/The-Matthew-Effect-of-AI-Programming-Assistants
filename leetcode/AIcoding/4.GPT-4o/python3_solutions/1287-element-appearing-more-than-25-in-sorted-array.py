class Solution:
    def findSpecialInteger(self, arr: List[int]) -> int:
        n = len(arr)
        threshold = n // 4
        for i in range(n):
            if i > 0 and arr[i] == arr[i - 1]:
                continue
            count = 1
            while i + 1 < n and arr[i] == arr[i + 1]:
                count += 1
                i += 1
            if count > threshold:
                return arr[i]
        return -1
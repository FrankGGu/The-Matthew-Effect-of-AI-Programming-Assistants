class Solution:
    def prevPermOpt1(self, arr: List[int]) -> List[int]:
        n = len(arr)
        left = -1
        for i in range(n - 1, 0, -1):
            if arr[i - 1] > arr[i]:
                left = i - 1
                break
        if left == -1:
            return arr
        right = left + 1
        for i in range(left + 1, n):
            if arr[i] < arr[left] and arr[i] > arr[right]:
                right = i
        arr[left], arr[right] = arr[right], arr[left]
        return arr
class Solution:
    def duplicateZeros(self, arr: List[int]) -> None:
        """
        Do not return anything, modify arr in-place instead.
        """
        n = len(arr)
        i = 0
        while i < n:
            if arr[i] == 0:
                for j in range(n-1, i, -1):
                    arr[j] = arr[j-1]
                i += 2
            else:
                i += 1
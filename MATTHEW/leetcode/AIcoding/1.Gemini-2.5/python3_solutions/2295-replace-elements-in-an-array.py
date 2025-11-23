class Solution:
    def replaceElements(self, arr: list[int]) -> list[int]:
        max_so_far = -1
        n = len(arr)

        for i in range(n - 1, -1, -1):
            current_val = arr[i]
            arr[i] = max_so_far
            max_so_far = max(max_so_far, current_val)

        return arr
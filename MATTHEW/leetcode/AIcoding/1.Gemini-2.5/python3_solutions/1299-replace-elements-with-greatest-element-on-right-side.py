class Solution:
    def replaceElements(self, arr: list[int]) -> list[int]:
        max_so_far = -1

        for i in range(len(arr) - 1, -1, -1):
            current_element = arr[i]
            arr[i] = max_so_far
            max_so_far = max(max_so_far, current_element)

        return arr
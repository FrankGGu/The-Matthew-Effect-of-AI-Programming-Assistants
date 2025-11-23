class Solution:
    def transformArray(self, arr: List[int]) -> List[int]:
        changed = True
        while changed:
            changed = False
            new_arr = arr.copy()
            for i in range(1, len(arr) - 1):
                if arr[i] > arr[i - 1] and arr[i] > arr[i + 1]:
                    new_arr[i] -= 1
                    changed = True
                elif arr[i] < arr[i - 1] and arr[i] < arr[i + 1]:
                    new_arr[i] += 1
                    changed = True
            arr = new_arr
        return arr
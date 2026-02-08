class Solution:
    def transformArray(self, arr: List[int]) -> List[int]:
        changed = True
        while changed:
            changed = False
            new_arr = arr[:]
            for i in range(1, len(arr) - 1):
                if arr[i - 1] > arr[i] and arr[i + 1] > arr[i]:
                    new_arr[i] = arr[i] + 1
                    changed = True
                elif arr[i - 1] < arr[i] and arr[i + 1] < arr[i]:
                    new_arr[i] = arr[i] - 1
                    changed = True
            arr = new_arr[:]
        return arr
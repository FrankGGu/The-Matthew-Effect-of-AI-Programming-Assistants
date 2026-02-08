class Solution:
    def findKthPositive(self, arr: list[int], k: int) -> int:
        current_num = 1
        arr_idx = 0

        while k > 0:
            if arr_idx < len(arr) and arr[arr_idx] == current_num:
                arr_idx += 1
            else:
                k -= 1
                if k == 0:
                    return current_num
            current_num += 1

        return current_num - 1
class Solution:
    def dismantlingAction(self, arr: str) -> int:
        if not arr:
            return 0
        left = 0
        max_len = 0
        char_index = {}

        for right in range(len(arr)):
            if arr[right] in char_index and char_index[arr[right]] >= left:
                left = char_index[arr[right]] + 1
            char_index[arr[right]] = right
            max_len = max(max_len, right - left + 1)

        return max_len
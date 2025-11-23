class Solution:
    def longestCommonPrefix(self, arr: List[int]) -> int:
        if not arr:
            return 0
        arr = list(map(str, arr))
        min_len = len(arr[0])
        for num in arr:
            min_len = min(min_len, len(num))
        for i in range(min_len):
            ch = arr[0][i]
            for num in arr:
                if num[i] != ch:
                    return i
        return min_len
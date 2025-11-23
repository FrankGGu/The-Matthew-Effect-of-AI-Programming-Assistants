class Solution:
    def maxLength(self, arr: List[str]) -> int:
        def backtrack(index: int, current: str) -> int:
            if len(current) != len(set(current)):
                return 0
            max_len = len(current)
            for i in range(index, len(arr)):
                max_len = max(max_len, backtrack(i + 1, current + arr[i]))
            return max_len

        return backtrack(0, "")
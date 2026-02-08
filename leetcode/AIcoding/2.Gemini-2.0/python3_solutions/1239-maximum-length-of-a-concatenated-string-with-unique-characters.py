class Solution:
    def maxLength(self, arr: list[str]) -> int:
        unique_arr = []
        for s in arr:
            if len(set(s)) == len(s):
                unique_arr.append(s)

        max_len = 0

        def backtrack(index, current_str):
            nonlocal max_len
            max_len = max(max_len, len(current_str))

            for i in range(index, len(unique_arr)):
                new_str = current_str + unique_arr[i]
                if len(set(new_str)) == len(new_str):
                    backtrack(i + 1, new_str)

        backtrack(0, "")
        return max_len
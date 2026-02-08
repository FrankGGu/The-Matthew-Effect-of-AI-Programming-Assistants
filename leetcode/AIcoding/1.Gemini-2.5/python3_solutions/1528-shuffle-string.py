class Solution:
    def restoreString(self, s: str, indices: list[int]) -> str:
        n = len(s)
        result_list = [''] * n

        for i in range(n):
            result_list[indices[i]] = s[i]

        return "".join(result_list)
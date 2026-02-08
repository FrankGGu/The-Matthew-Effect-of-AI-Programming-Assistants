class Solution:
    def longestDecomposition(self, text: str) -> int:
        n = len(text)
        res = 0
        left, right = 0, n - 1
        l_str, r_str = "", ""

        while left <= right:
            l_str += text[left]
            r_str = text[right] + r_str

            if left == right:
                break

            if l_str == r_str:
                res += 2
                l_str, r_str = "", ""

            left += 1
            right -= 1

        if l_str or r_str:
            res += 1

        return res
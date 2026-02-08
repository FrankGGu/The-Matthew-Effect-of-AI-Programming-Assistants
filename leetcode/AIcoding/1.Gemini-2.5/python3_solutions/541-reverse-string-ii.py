class Solution:
    def reverseStr(self, s: str, k: int) -> str:
        s_list = list(s)
        n = len(s_list)

        for i in range(0, n, 2 * k):
            left = i
            right = min(i + k - 1, n - 1)

            while left < right:
                s_list[left], s_list[right] = s_list[right], s_list[left]
                left += 1
                right -= 1

        return "".join(s_list)
class Solution:
    def addToArrayForm(self, num: list[int], k: int) -> list[int]:
        ans = []
        i = len(num) - 1

        while i >= 0 or k > 0:
            if i >= 0:
                digit_from_num = num[i]
            else:
                digit_from_num = 0

            current_sum = digit_from_num + k
            ans.append(current_sum % 10)
            k = current_sum // 10
            i -= 1

        return ans[::-1]
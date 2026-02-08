class Solution:
    def addNegabinary(self, arr1: list[int], arr2: list[int]) -> list[int]:
        res = []
        carry = 0
        i = len(arr1) - 1
        j = len(arr2) - 1

        while i >= 0 or j >= 0 or carry != 0:
            d1 = arr1[i] if i >= 0 else 0
            d2 = arr2[j] if j >= 0 else 0

            val = d1 + d2 + carry

            s = val % 2
            carry = -(val // 2) 

            res.append(s)

            i -= 1
            j -= 1

        while len(res) > 1 and res[-1] == 0:
            res.pop()

        return res[::-1]
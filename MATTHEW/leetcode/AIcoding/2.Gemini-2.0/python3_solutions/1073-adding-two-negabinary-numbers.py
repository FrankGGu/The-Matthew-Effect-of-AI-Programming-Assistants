class Solution:
    def addNegabinary(self, arr1: List[int], arr2: List[int]) -> List[int]:
        i, j = len(arr1) - 1, len(arr2) - 1
        carry = 0
        res = []
        while i >= 0 or j >= 0 or carry != 0:
            val1 = arr1[i] if i >= 0 else 0
            val2 = arr2[j] if j >= 0 else 0
            sum_val = val1 + val2 + carry

            if sum_val == 0:
                res.append(0)
                carry = 0
            elif sum_val == 1:
                res.append(1)
                carry = 0
            elif sum_val == 2:
                res.append(0)
                carry = -1
            elif sum_val == -1:
                res.append(1)
                carry = 1
            elif sum_val == 3:
                res.append(1)
                carry = -1

            i -= 1
            j -= 1

        while len(res) > 1 and res[-1] == 0:
            res.pop()

        return res[::-1]
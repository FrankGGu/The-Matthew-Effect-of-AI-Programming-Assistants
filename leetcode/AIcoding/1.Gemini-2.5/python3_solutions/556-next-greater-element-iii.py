class Solution:
    def nextGreaterElement(self, n: int) -> int:
        s = list(str(n))
        length = len(s)

        k = -1
        for i in range(length - 2, -1, -1):
            if s[i] < s[i+1]:
                k = i
                break

        if k == -1:
            return -1

        l = -1
        for i in range(length - 1, k, -1):
            if s[k] < s[i]:
                l = i
                break

        s[k], s[l] = s[l], s[k]

        s[k+1:] = s[k+1:][::-1]

        result = int("".join(s))

        if result > 2**31 - 1:
            return -1

        return result
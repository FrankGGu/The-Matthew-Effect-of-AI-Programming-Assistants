class Solution:
    def minOperations(self, num1: int, num2: int) -> int:
        s1 = str(num1)
        s2 = str(num2)
        n1 = len(s1)
        n2 = len(s2)
        if n1 != n2:
            return -1

        diff = 0
        ans = 0
        i = 0
        while i < n1:
            if s1[i] != s2[i]:
                ans += 1
                j = i
                while j < n1 and s1[j] != s2[j]:
                    j += 1
                i = j
            else:
                i += 1

        return ans
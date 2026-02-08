class Solution:
    def minOperations(self, s: str) -> int:
        n = len(s)
        count1 = 0
        count2 = 0
        for i in range(n):
            if i % 2 == 0:
                if s[i] == '1':
                    count1 += 1
                else:
                    count2 += 1
            else:
                if s[i] == '0':
                    count1 += 1
                else:
                    count2 += 1
        return min(count1, count2)
class Solution:
    def checkStrings(self, s1: str, s2: str) -> bool:
        if len(s1) != len(s2):
            return False
        n = len(s1)
        even_s1 = []
        odd_s1 = []
        even_s2 = []
        odd_s2 = []
        for i in range(n):
            if i % 2 == 0:
                even_s1.append(s1[i])
                even_s2.append(s2[i])
            else:
                odd_s1.append(s1[i])
                odd_s2.append(s2[i])
        even_s1.sort()
        odd_s1.sort()
        even_s2.sort()
        odd_s2.sort()
        return even_s1 == even_s2 and odd_s1 == odd_s2
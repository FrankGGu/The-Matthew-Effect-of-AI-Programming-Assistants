class Solution:
    def checkStrings(self, s1: str, s2: str) -> bool:
        odd1 = sorted([s1[i] for i in range(len(s1)) if i % 2 != 0])
        even1 = sorted([s1[i] for i in range(len(s1)) if i % 2 == 0])
        odd2 = sorted([s2[i] for i in range(len(s2)) if i % 2 != 0])
        even2 = sorted([s2[i] for i in range(len(s2)) if i % 2 == 0])
        return odd1 == odd2 and even1 == even2
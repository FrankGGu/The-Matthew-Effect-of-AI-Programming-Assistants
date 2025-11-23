class Solution:
    def findOriginalArray(self, pref: List[int]) -> List[int]:
        n = len(pref)
        original = [pref[0]]
        for i in range(1, n):
            original.append(pref[i] ^ pref[i-1])
        return original
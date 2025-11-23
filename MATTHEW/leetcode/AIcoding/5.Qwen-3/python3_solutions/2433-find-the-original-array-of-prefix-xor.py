class Solution:
    def findArray(self, pref: List[int]) -> List[int]:
        n = len(pref)
        res = [0] * n
        res[0] = pref[0]
        for i in range(1, n):
            res[i] = pref[i] ^ pref[i-1]
        return res
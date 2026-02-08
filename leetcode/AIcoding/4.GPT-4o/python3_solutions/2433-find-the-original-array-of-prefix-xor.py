class Solution:
    def findArray(self, pref: List[int]) -> List[int]:
        n = len(pref)
        original = [0] * n
        original[0] = pref[0]

        for i in range(1, n):
            original[i] = pref[i] ^ pref[i - 1]

        return original
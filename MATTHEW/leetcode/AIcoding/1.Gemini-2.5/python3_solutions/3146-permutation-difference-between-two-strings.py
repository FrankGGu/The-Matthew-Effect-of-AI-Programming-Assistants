class Solution:
    def findPermutationDifference(self, s: str, t: str) -> int:

        t_indices = {}
        for i, char in enumerate(t):
            t_indices[char] = i

        total_difference = 0
        for i, char in enumerate(s):
            total_difference += abs(i - t_indices[char])

        return total_difference
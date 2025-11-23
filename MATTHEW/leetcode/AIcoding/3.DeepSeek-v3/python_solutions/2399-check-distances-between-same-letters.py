class Solution:
    def checkDistances(self, s: str, distance: List[int]) -> bool:
        first_occurrence = {}
        for idx, char in enumerate(s):
            if char in first_occurrence:
                if idx - first_occurrence[char] - 1 != distance[ord(char) - ord('a')]:
                    return False
            else:
                first_occurrence[char] = idx
        return True
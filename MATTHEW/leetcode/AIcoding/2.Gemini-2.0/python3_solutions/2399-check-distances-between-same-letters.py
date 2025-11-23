class Solution:
    def checkDistances(self, s: str, distance: list[int]) -> bool:
        first_occurrence = {}
        for i, char in enumerate(s):
            if char not in first_occurrence:
                first_occurrence[char] = i

        for i, char in enumerate(s):
            if i > first_occurrence[char]:
                dist = i - first_occurrence[char] - 1
                index = ord(char) - ord('a')
                if dist != distance[index]:
                    return False

        return True
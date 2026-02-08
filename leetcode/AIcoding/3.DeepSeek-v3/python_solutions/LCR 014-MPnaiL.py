from collections import defaultdict

class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        if len(s1) > len(s2):
            return False

        s1_count = defaultdict(int)
        s2_count = defaultdict(int)

        for i in range(len(s1)):
            s1_count[s1[i]] += 1
            s2_count[s2[i]] += 1

        matches = 0
        for c in 'abcdefghijklmnopqrstuvwxyz':
            if s1_count[c] == s2_count[c]:
                matches += 1

        left = 0
        for right in range(len(s1), len(s2)):
            if matches == 26:
                return True

            char = s2[right]
            s2_count[char] += 1
            if s2_count[char] == s1_count[char]:
                matches += 1
            elif s2_count[char] == s1_count[char] + 1:
                matches -= 1

            char = s2[left]
            s2_count[char] -= 1
            if s2_count[char] == s1_count[char]:
                matches += 1
            elif s2_count[char] == s1_count[char] - 1:
                matches -= 1

            left += 1

        return matches == 26
class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        from collections import defaultdict

        if len(s1) > len(s2):
            return False

        s1_count = defaultdict(int)
        s2_count = defaultdict(int)

        for char in s1:
            s1_count[char] += 1

        window_size = len(s1)
        for i in range(window_size):
            char = s2[i]
            s2_count[char] += 1

        if s1_count == s2_count:
            return True

        for i in range(window_size, len(s2)):
            left_char = s2[i - window_size]
            s2_count[left_char] -= 1
            if s2_count[left_char] == 0:
                del s2_count[left_char]

            right_char = s2[i]
            s2_count[right_char] += 1

            if s1_count == s2_count:
                return True

        return False
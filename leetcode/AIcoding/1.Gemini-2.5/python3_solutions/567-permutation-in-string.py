class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        len_s1 = len(s1)
        len_s2 = len(s2)

        if len_s1 > len_s2:
            return False

        s1_counts = [0] * 26
        window_counts = [0] * 26

        for char_code in s1:
            s1_counts[ord(char_code) - ord('a')] += 1

        match = 0
        for i in range(len_s1):
            window_counts[ord(s2[i]) - ord('a')] += 1

        for i in range(26):
            if s1_counts[i] == window_counts[i]:
                match += 1

        if match == 26:
            return True

        for i in range(len_s1, len_s2):
            left_char_idx = ord(s2[i - len_s1]) - ord('a')
            right_char_idx = ord(s2[i]) - ord('a')

            if s1_counts[left_char_idx] == window_counts[left_char_idx]:
                match -= 1
            window_counts[left_char_idx] -= 1
            if s1_counts[left_char_idx] == window_counts[left_char_idx]:
                match += 1

            if s1_counts[right_char_idx] == window_counts[right_char_idx]:
                match -= 1
            window_counts[right_char_idx] += 1
            if s1_counts[right_char_idx] == window_counts[right_char_idx]:
                match += 1

            if match == 26:
                return True

        return False
class Solution:
    def checkOnesSegment(self, s: str) -> bool:
        first_one_idx = s.find('1')

        if first_one_idx == -1:
            return True

        last_one_idx = s.rfind('1')

        if '0' in s[first_one_idx : last_one_idx + 1]:
            return False

        return True
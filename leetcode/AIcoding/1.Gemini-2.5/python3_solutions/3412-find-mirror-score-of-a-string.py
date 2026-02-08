class Solution:
    def findMirrorScore(self, s: str) -> int:
        mirror_map = {
            '0': '0', '1': '1', '8': '8',
            '6': '9', '9': '6'
        }

        score = 0
        left = 0
        right = len(s) - 1

        while left <= right:
            char_left = s[left]
            char_right = s[right]

            if char_left in mirror_map and mirror_map[char_left] == char_right:
                score += 1

            left += 1
            right -= 1

        return score
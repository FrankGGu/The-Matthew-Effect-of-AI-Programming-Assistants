class Solution:
    def minimumChairs(self, s: str) -> int:
        max_chairs = 0
        current = 0
        for char in s:
            if char == 'E':
                current += 1
                max_chairs = max(max_chairs, current)
            else:
                current -= 1
        return max_chairs
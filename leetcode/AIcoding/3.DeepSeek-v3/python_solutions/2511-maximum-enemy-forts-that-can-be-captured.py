class Solution:
    def captureForts(self, forts: List[int]) -> int:
        max_captured = 0
        n = len(forts)

        for i in range(n):
            if forts[i] == 1:
                left = i - 1
                while left >= 0 and forts[left] == 0:
                    left -= 1
                if left >= 0 and forts[left] == -1:
                    max_captured = max(max_captured, i - left - 1)

                right = i + 1
                while right < n and forts[right] == 0:
                    right += 1
                if right < n and forts[right] == -1:
                    max_captured = max(max_captured, right - i - 1)

        return max_captured
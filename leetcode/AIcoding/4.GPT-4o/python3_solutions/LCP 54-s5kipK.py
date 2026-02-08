class Solution:
    def captureForts(self, forts: List[int]) -> int:
        max_captured = 0
        count = 0

        for fort in forts:
            if fort == 1:
                max_captured = max(max_captured, count)
                count = 0
            elif fort == -1:
                count = 0
            else:
                count += 1

        # Check for the last segment if it ends with 0s
        max_captured = max(max_captured, count)

        return max_captured
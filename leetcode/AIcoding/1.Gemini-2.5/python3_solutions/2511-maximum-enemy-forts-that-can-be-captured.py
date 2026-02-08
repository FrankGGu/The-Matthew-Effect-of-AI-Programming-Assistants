class Solution:
    def maximumEnemyForts(self, forts: List[int]) -> int:
        n = len(forts)
        max_captured = 0

        last_fort_idx = -1

        for i in range(n):
            if forts[i] != 0:
                if last_fort_idx != -1:
                    if forts[last_fort_idx] == 1 and forts[i] == -1:
                        captured_count = i - last_fort_idx - 1
                        max_captured = max(max_captured, captured_count)
                    elif forts[last_fort_idx] == -1 and forts[i] == 1:
                        captured_count = i - last_fort_idx - 1
                        max_captured = max(max_captured, captured_count)

                last_fort_idx = i

        return max_captured
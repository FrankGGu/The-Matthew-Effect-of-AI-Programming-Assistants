class Solution:
    def minimumRecolors(self, blocks: str, k: int) -> int:
        min_operations = float('inf')
        n = len(blocks)
        for i in range(n - k + 1):
            window = blocks[i:i+k]
            white_count = window.count('W')
            if white_count < min_operations:
                min_operations = white_count
                if min_operations == 0:
                    break
        return min_operations
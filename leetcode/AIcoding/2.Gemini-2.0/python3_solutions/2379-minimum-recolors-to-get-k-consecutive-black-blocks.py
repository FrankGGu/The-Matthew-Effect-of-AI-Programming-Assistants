class Solution:
    def minimumRecolors(self, blocks: str, k: int) -> int:
        n = len(blocks)
        white_count = 0
        for i in range(k):
            if blocks[i] == 'W':
                white_count += 1

        min_recolors = white_count

        for i in range(k, n):
            if blocks[i] == 'W':
                white_count += 1
            if blocks[i - k] == 'W':
                white_count -= 1
            min_recolors = min(min_recolors, white_count)

        return min_recolors
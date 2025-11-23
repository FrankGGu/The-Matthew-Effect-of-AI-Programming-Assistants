class Solution:
    def minimumRecolors(self, blocks: str, k: int) -> int:
        n = len(blocks)

        current_recolors = 0
        for i in range(k):
            if blocks[i] == 'W':
                current_recolors += 1

        min_recolors = current_recolors

        for i in range(k, n):
            if blocks[i - k] == 'W':
                current_recolors -= 1
            if blocks[i] == 'W':
                current_recolors += 1
            min_recolors = min(min_recolors, current_recolors)

        return min_recolors
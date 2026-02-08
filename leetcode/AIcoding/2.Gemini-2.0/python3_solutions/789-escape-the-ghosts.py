class Solution:
    def escapeGhosts(self, ghosts: list[list[int]], target: list[int], source: list[int]) -> bool:
        distance = abs(target[0] - source[0]) + abs(target[1] - source[1])
        for ghost in ghosts:
            ghost_distance = abs(target[0] - ghost[0]) + abs(target[1] - ghost[1])
            if ghost_distance <= distance:
                return False
        return True
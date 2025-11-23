class Solution:
    def escapeGhosts(self, ghosts: list[list[int]], target: list[int]) -> bool:
        player_dist = abs(target[0]) + abs(target[1])

        for ghost_pos in ghosts:
            ghost_dist = abs(ghost_pos[0] - target[0]) + abs(ghost_pos[1] - target[1])
            if ghost_dist <= player_dist:
                return False

        return True
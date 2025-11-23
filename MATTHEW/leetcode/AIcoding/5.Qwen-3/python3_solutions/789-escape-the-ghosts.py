class Solution:
    def escapeGhosts(self, ghosts: List[List[int]]) -> bool:
        player = [0, 0]
        for ghost in ghosts:
            if abs(ghost[0] - player[0]) + abs(ghost[1] - player[1]) <= abs(player[0]) + abs(player[1]):
                return False
        return True
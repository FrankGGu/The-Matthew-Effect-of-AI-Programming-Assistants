from typing import List

class Solution:
    def robot(self, command: str, queries: List[List[int]]) -> List[bool]:
        visited_in_cycle = set()
        current_x, current_y = 0, 0
        visited_in_cycle.add((0, 0))

        for move in command:
            if move == 'U':
                current_y += 1
            elif move == 'R':
                current_x += 1
            visited_in_cycle.add((current_x, current_y))

        dx = command.count('R')
        dy = command.count('U')

        results = []
        for qx, qy in queries:
            is_reachable = False

            for rx, ry in visited_in_cycle:
                if qx < rx or qy < ry:
                    continue

                if dx == 0 and dy == 0:
                    if qx == rx and qy == ry:
                        is_reachable = True
                        break
                elif dx == 0:
                    if qx == rx and (qy - ry) % dy == 0:
                        k = (qy - ry) // dy
                        if k >= 0:
                            is_reachable = True
                            break
                elif dy == 0:
                    if qy == ry and (qx - rx) % dx == 0:
                        k = (qx - rx) // dx
                        if k >= 0:
                            is_reachable = True
                            break
                else:
                    if (qx - rx) % dx == 0 and (qy - ry) % dy == 0:
                        k_x = (qx - rx) // dx
                        k_y = (qy - ry) // dy
                        if k_x == k_y and k_x >= 0:
                            is_reachable = True
                            break

            results.append(is_reachable)

        return results
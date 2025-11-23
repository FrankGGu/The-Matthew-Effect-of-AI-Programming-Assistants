class Solution:
    def survivedRobotsHealths(self, positions: List[int], healths: List[int], directions: str) -> List[int]:
        n = len(positions)
        robots = sorted([(positions[i], healths[i], directions[i], i) for i in range(n)], key=lambda x: x[0])
        stack = []

        for pos, health, direction, idx in robots:
            if direction == 'R':
                stack.append((pos, health, direction, idx))
            else:
                while stack and stack[-1][2] == 'R':
                    top_pos, top_health, top_dir, top_idx = stack.pop()
                    if top_health > health:
                        health = 0
                        stack.append((top_pos, top_health - 1, top_dir, top_idx))
                        break
                    elif top_health < health:
                        health -= 1
                    else:
                        health = 0
                        break
                else:
                    if health > 0:
                        stack.append((pos, health, direction, idx))

        stack.sort(key=lambda x: x[3])
        res = [robot[1] for robot in stack]
        return res
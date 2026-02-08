class Solution:
    def robotCollisions(self, directions: str, healths: list[int], positions: list[int]) -> list[int]:
        robots = sorted([(positions[i], healths[i], directions[i], i) for i in range(len(positions))])
        stack = []
        indices_to_remove = set()
        for pos, health, direction, index in robots:
            if direction == 'R':
                stack.append((pos, health, direction, index))
            else:
                while stack and health > 0:
                    pos2, health2, direction2, index2 = stack[-1]
                    if direction2 == 'R':
                        if health > health2:
                            health -= health2
                            indices_to_remove.add(index2)
                            stack.pop()
                        elif health < health2:
                            health2 -= health
                            health = 0
                            stack[-1] = (pos2, health2, direction2, index2)
                        else:
                            health = 0
                            indices_to_remove.add(index2)
                            stack.pop()
                    else:
                        break
                if health > 0:
                    healths[index] = health
                else:
                    indices_to_remove.add(index)

        result = []
        for pos, health, direction, index in stack:
            healths[index] = health

        for i in range(len(healths)):
            if i not in indices_to_remove:
                result.append(healths[i])
        return result
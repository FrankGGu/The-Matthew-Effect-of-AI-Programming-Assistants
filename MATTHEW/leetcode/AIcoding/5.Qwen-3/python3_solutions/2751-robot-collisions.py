class Solution:
    def survivedRobotsHealths(self, positions: List[int], healths: List[int]) -> List[int]:
        robots = sorted(zip(positions, healths, range(len(positions))))
        stack = []
        for pos, health, idx in robots:
            while stack and stack[-1][0] < pos and stack[-1][1] < health:
                prev_pos, prev_health, prev_idx = stack.pop()
                health -= prev_health
            if not stack or stack[-1][0] > pos:
                stack.append((pos, health, idx))
            else:
                stack[-1] = (stack[-1][0], health, stack[-1][2])
        return [health for pos, health, idx in sorted(stack, key=lambda x: x[2])]
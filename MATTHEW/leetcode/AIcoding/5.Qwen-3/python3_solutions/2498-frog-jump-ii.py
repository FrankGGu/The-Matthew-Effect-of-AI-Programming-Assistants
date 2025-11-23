class Solution:
    def canCross(self, stones: List[int]) -> bool:
        from collections import defaultdict, deque

        if stones[0] != 0:
            return False

        jump_map = defaultdict(set)
        for i, stone in enumerate(stones):
            jump_map[stone].add(i)

        queue = deque()
        queue.append((0, 0))
        visited = set()
        visited.add((0, 0))

        while queue:
            pos, step = queue.popleft()
            if pos == stones[-1]:
                return True
            for next_step in [step - 1, step, step + 1]:
                if next_step <= 0:
                    continue
                next_pos = pos + next_step
                if next_pos in jump_map:
                    for next_index in jump_map[next_pos]:
                        if (next_pos, next_index) not in visited:
                            visited.add((next_pos, next_index))
                            queue.append((next_pos, next_index))
        return False
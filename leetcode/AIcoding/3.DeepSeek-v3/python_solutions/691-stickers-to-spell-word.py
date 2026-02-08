from collections import defaultdict, deque

class Solution:
    def minStickers(self, stickers: List[str], target: str) -> int:
        target_count = defaultdict(int)
        for c in target:
            target_count[c] += 1

        sticker_counts = []
        for sticker in stickers:
            count = defaultdict(int)
            for c in sticker:
                if c in target_count:
                    count[c] += 1
            if count:
                sticker_counts.append(count)

        queue = deque([(target_count, 0)])
        visited = set()
        visited.add(tuple(sorted(target_count.items())))

        while queue:
            current, steps = queue.popleft()

            if not current:
                return steps

            for sticker in sticker_counts:
                new_current = defaultdict(int)
                for key in current:
                    if key in sticker:
                        new_val = current[key] - sticker[key]
                        if new_val > 0:
                            new_current[key] = new_val
                    else:
                        new_current[key] = current[key]

                state = tuple(sorted(new_current.items()))
                if state not in visited:
                    visited.add(state)
                    queue.append((new_current, steps + 1))

        return -1
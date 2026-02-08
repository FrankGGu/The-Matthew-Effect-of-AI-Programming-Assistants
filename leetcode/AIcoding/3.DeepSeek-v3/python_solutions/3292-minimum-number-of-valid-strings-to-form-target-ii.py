class Solution:
    def minStickers(self, stickers: List[str], target: str) -> int:
        from collections import defaultdict, deque

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

        queue = deque([(tuple(target_count.items()), 0)])
        visited = set()
        visited.add(tuple(target_count.items()))

        while queue:
            current, steps = queue.popleft()
            if all(v <= 0 for k, v in current):
                return steps

            for sticker in sticker_counts:
                new_current = list(current)
                for i in range(len(new_current)):
                    char, cnt = new_current[i]
                    if char in sticker:
                        new_current[i] = (char, max(cnt - sticker[char], 0))
                new_current_tuple = tuple(new_current)
                if new_current_tuple not in visited:
                    visited.add(new_current_tuple)
                    queue.append((new_current_tuple, steps + 1))

        return -1
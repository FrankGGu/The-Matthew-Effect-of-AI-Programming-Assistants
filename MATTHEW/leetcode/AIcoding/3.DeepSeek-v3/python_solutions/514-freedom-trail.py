class Solution:
    def findRotateSteps(self, ring: str, key: str) -> int:
        from collections import defaultdict
        import math

        char_positions = defaultdict(list)
        for i, char in enumerate(ring):
            char_positions[char].append(i)

        memo = {}
        n = len(ring)

        def dp(pos, key_index):
            if key_index == len(key):
                return 0
            if (pos, key_index) in memo:
                return memo[(pos, key_index)]

            current_char = key[key_index]
            min_steps = math.inf
            for next_pos in char_positions[current_char]:
                steps = abs(pos - next_pos)
                steps = min(steps, n - steps)
                total_steps = steps + dp(next_pos, key_index + 1)
                if total_steps < min_steps:
                    min_steps = total_steps
            memo[(pos, key_index)] = min_steps + 1
            return min_steps + 1

        return dp(0, 0)
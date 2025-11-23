class Solution:
    def maximumTotalHeight(self, n: int, k: int) -> int:
        from collections import defaultdict

        def get_heights():
            heights = [0] * n
            for i in range(n):
                if i % 2 == 0:
                    heights[i] = k
                else:
                    heights[i] = k - 1
            return heights

        def is_valid(heights):
            seen = set()
            for h in heights:
                if h in seen:
                    return False
                seen.add(h)
            return True

        heights = get_heights()
        if is_valid(heights):
            return sum(heights)

        from itertools import permutations

        def generate_unique_heights():
            unique_heights = []
            for i in range(n):
                if i % 2 == 0:
                    unique_heights.append(k)
                else:
                    unique_heights.append(k - 1)
            return unique_heights

        heights = generate_unique_heights()
        if is_valid(heights):
            return sum(heights)

        heights = [k] * n
        for i in range(1, n):
            heights[i] = heights[i - 1] - 1
        if is_valid(heights):
            return sum(heights)

        heights = [k] * n
        for i in range(1, n):
            heights[i] = heights[i - 1] + 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k - 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k - 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k - 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k - 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k - 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k - 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for i in range(n):
            heights[i] = k - 1
        if is_valid(heights):
            return sum(heights)

        heights = [0] * n
        for......
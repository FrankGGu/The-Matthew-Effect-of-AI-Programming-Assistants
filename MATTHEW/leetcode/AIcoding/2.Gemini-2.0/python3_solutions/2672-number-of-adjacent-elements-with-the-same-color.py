class Solution:
    def countAdjacentPairs(self, n: int, nums: List[int], queries: List[List[int]]) -> List[int]:
        colors = [0] * n
        res = []

        def count_adj(arr):
            count = 0
            for i in range(len(arr) - 1):
                if arr[i] == arr[i+1] and arr[i] != 0:
                    count += 1
            return count

        initial_count = count_adj(colors)

        for index, color in queries:
            old_color = colors[index]
            colors[index] = color

            diff = 0

            if index > 0:
                if colors[index - 1] == old_color and old_color != 0:
                    diff -= 1
                if colors[index - 1] == color and color != 0:
                    diff += 1

            if index < n - 1:
                if colors[index + 1] == old_color and old_color != 0:
                    diff -= 1
                if colors[index + 1] == color and color != 0:
                    diff += 1

            initial_count += diff
            res.append(initial_count)

        return res
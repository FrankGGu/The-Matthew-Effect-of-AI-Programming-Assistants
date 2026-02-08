class Solution:
    def colorTheArray(self, n: int, queries: List[List[int]]) -> List[int]:
        colors = [0] * n
        count = 0
        result = []

        for index, color in queries:
            old_color = colors[index]
            colors[index] = color

            if old_color != 0:
                if index > 0 and colors[index - 1] == old_color:
                    count -= 1
                if index < n - 1 and colors[index + 1] == old_color:
                    count -= 1

            if color != 0:
                if index > 0 and colors[index - 1] == color:
                    count += 1
                if index < n - 1 and colors[index + 1] == color:
                    count += 1

            result.append(count)

        return result
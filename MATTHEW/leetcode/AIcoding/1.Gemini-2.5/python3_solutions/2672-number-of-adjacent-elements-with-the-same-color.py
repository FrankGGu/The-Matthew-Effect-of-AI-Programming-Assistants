from typing import List

class Solution:
    def colorTheArray(self, n: int, queries: List[List[int]]) -> List[int]:
        colors = [0] * n

        current_same_color_pairs = 0
        if n > 0:
            current_same_color_pairs = max(0, n - 1)

        ans = []

        for query in queries:
            idx, new_color = query
            old_color = colors[idx]

            # Check left neighbor
            if idx > 0:
                # If old_color formed a pair with left neighbor, decrement count
                if colors[idx - 1] == old_color:
                    current_same_color_pairs -= 1
                # If new_color forms a pair with left neighbor, increment count
                if colors[idx - 1] == new_color:
                    current_same_color_pairs += 1

            # Check right neighbor
            if idx < n - 1:
                # If old_color formed a pair with right neighbor, decrement count
                if colors[idx + 1] == old_color:
                    current_same_color_pairs -= 1
                # If new_color forms a pair with right neighbor, increment count
                if colors[idx + 1] == new_color:
                    current_same_color_pairs += 1

            # Update the color at the current index
            colors[idx] = new_color

            ans.append(current_same_color_pairs)

        return ans
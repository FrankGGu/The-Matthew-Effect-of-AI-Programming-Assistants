class Solution:
    def perfectMenu(self, materials: List[int], cookbooks: List[List[int]], attribute: List[List[int]], limit: int) -> int:
        max_delicious = -1
        n = len(cookbooks)

        def backtrack(index, current_materials, current_x, current_y):
            nonlocal max_delicious
            if current_y >= limit:
                max_delicious = max(max_delicious, current_x)

            if index == n:
                return

            # Skip current recipe
            backtrack(index + 1, current_materials.copy(), current_x, current_y)

            # Try to use current recipe
            new_materials = current_materials.copy()
            valid = True
            for i in range(5):
                if new_materials[i] < cookbooks[index][i]:
                    valid = False
                    break
                new_materials[i] -= cookbooks[index][i]

            if valid:
                backtrack(index + 1, new_materials, current_x + attribute[index][0], current_y + attribute[index][1])

        backtrack(0, materials.copy(), 0, 0)
        return max_delicious
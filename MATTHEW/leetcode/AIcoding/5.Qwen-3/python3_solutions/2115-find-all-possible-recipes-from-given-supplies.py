from collections import defaultdict, deque
from typing import List

class Solution:
    def findAllRecipes(self, recipes: List[int], ingredients: List[List[int]], supplies: List[int]) -> List[int]:
        supply_set = set(supplies)
        graph = defaultdict(list)
        in_degree = defaultdict(int)
        recipe_index = {}

        for i, recipe in enumerate(recipes):
            recipe_index[recipe] = i
            for ingredient in ingredients[i]:
                graph[ingredient].append(recipe)
                in_degree[recipe] += 1

        queue = deque()
        for supply in supplies:
            queue.append(supply)

        result = []

        while queue:
            current = queue.popleft()
            if current in recipe_index:
                result.append(current)
            for neighbor in graph[current]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return result
from collections import defaultdict, deque

class Solution:
    def findAllRecipes(self, recipes: List[str], ingredients: List[List[str]], supplies: List[str]) -> List[str]:
        graph = defaultdict(list)
        in_degree = defaultdict(int)
        supply_set = set(supplies)
        possible_recipes = []

        for recipe, ingredient_list in zip(recipes, ingredients):
            for ingredient in ingredient_list:
                graph[ingredient].append(recipe)
                in_degree[recipe] += 1

        queue = deque(supplies)

        while queue:
            current = queue.popleft()
            if current in supply_set or current in recipes:
                for neighbor in graph[current]:
                    in_degree[neighbor] -= 1
                    if in_degree[neighbor] == 0:
                        queue.append(neighbor)
                        possible_recipes.append(neighbor)

        return possible_recipes
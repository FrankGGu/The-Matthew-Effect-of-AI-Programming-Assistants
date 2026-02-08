import collections

class Solution:
    def findAllRecipes(self, recipes: list[str], ingredients: list[list[str]], supplies: list[str]) -> list[str]:
        adj = collections.defaultdict(list)
        in_degree = collections.defaultdict(int)

        available_items = set(supplies)

        possible_recipes = []

        q = collections.deque()

        for i, recipe in enumerate(recipes):
            in_degree[recipe] = 0
            for ingredient in ingredients[i]:
                if ingredient not in available_items:
                    in_degree[recipe] += 1
                    adj[ingredient].append(recipe)

        for recipe in recipes:
            if in_degree[recipe] == 0:
                q.append(recipe)
                possible_recipes.append(recipe)

        while q:
            current_available_recipe = q.popleft()

            for dependent_recipe in adj[current_available_recipe]:
                in_degree[dependent_recipe] -= 1
                if in_degree[dependent_recipe] == 0:
                    q.append(dependent_recipe)
                    possible_recipes.append(dependent_recipe)

        return possible_recipes
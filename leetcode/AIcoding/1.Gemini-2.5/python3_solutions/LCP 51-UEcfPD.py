import collections

class Solution:
    def findAllRecipes(self, recipes: list[str], ingredients: list[list[str]], supplies: list[str]) -> list[str]:
        indegree = collections.defaultdict(int)
        graph = collections.defaultdict(list)

        available_supplies = set(supplies)

        q = collections.deque()
        ans = []

        recipe_set = set(recipes)

        for i in range(len(recipes)):
            recipe_name = recipes[i]
            required_ingredients = ingredients[i]

            current_indegree = 0
            for ing in required_ingredients:
                if ing not in available_supplies:
                    current_indegree += 1
                    graph[ing].append(recipe_name)

            indegree[recipe_name] = current_indegree

            if current_indegree == 0:
                q.append(recipe_name)

        while q:
            made_recipe = q.popleft()
            ans.append(made_recipe)

            # Now 'made_recipe' itself becomes an available ingredient
            # Check all recipes that might need 'made_recipe' as an ingredient
            for next_recipe in graph[made_recipe]:
                indegree[next_recipe] -= 1
                if indegree[next_recipe] == 0:
                    q.append(next_recipe)

        return ans
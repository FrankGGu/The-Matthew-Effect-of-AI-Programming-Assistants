from collections import defaultdict, deque

class Solution:
    def findAllRecipes(self, recipes: list[str], ingredients: list[list[str]], supplies: list[str]) -> list[str]:
        graph = defaultdict(list)
        indegree = {}
        for recipe in recipes:
            indegree[recipe] = 0

        for i in range(len(recipes)):
            recipe = recipes[i]
            for ingredient in ingredients[i]:
                if ingredient not in indegree:
                    continue
                graph[ingredient].append(recipe)
                indegree[recipe] += 1

        queue = deque(supplies)
        result = []

        while queue:
            node = queue.popleft()

            for neighbor in graph[node]:
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)
                    result.append(neighbor)

        return result
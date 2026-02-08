from collections import defaultdict, deque

class Solution:
    def findAllRecipes(self, recipes: List[str], ingredients: List[List[str]], supplies: List[str]) -> List[str]:
        graph = defaultdict(list)
        indegree = defaultdict(int)
        supply_set = set(supplies)

        for recipe, ing in zip(recipes, ingredients):
            indegree[recipe] = len(ing)
            for i in ing:
                graph[i].append(recipe)

        result = []
        queue = deque([r for r in supplies])

        while queue:
            supply = queue.popleft()
            for recipe in graph[supply]:
                indegree[recipe] -= 1
                if indegree[recipe] == 0:
                    result.append(recipe)
                    queue.append(recipe)

        return [r for r in recipes if r in result]
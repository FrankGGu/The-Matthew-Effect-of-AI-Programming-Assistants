class Solution:
    def findProductRecommendations(self, pairs: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        graph = defaultdict(set)
        result = []

        for a, b in pairs:
            graph[a].add(b)
            graph[b].add(a)

        for user in graph:
            neighbors = graph[user]
            for neighbor in neighbors:
                for friend in graph[neighbor]:
                    if friend != user and friend in neighbors:
                        result.append([user, friend])

        return result
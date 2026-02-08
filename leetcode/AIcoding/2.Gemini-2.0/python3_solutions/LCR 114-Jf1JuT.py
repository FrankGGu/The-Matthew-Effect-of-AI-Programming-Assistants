from collections import defaultdict

class Solution:
    def alienOrder(self, words: list[str]) -> str:
        adj = defaultdict(set)
        in_degree = {}
        for word in words:
            for char in word:
                in_degree[char] = 0

        for i in range(len(words) - 1):
            word1, word2 = words[i], words[i + 1]
            min_len = min(len(word1), len(word2))
            for j in range(min_len):
                if word1[j] != word2[j]:
                    if word2[j] not in adj[word1[j]]:
                        adj[word1[j]].add(word2[j])
                        in_degree[word2[j]] += 1
                    break
            else:
                if len(word1) > len(word2):
                    return ""

        queue = [char for char in in_degree if in_degree[char] == 0]
        result = []

        while queue:
            char = queue.pop(0)
            result.append(char)
            for neighbor in adj[char]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        if len(result) != len(in_degree):
            return ""

        return "".join(result)
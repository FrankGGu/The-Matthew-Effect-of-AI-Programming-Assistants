class TrieNode:
    def __init__(self):
        self.children = {}
        self.min_cost_ending_here = float('inf')

class Solution:
    def minimumCost(self, target: str, words: list[str], costs: list[int]) -> int:
        root = TrieNode()

        for i in range(len(words)):
            word = words[i]
            cost = costs[i]
            node = root
            for char in word:
                if char not in node.children:
                    node.children[char] = TrieNode()
                node = node.children[char]
            node.min_cost_ending_here = min(node.min_cost_ending_here, cost)

        n = len(target)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(n):
            if dp[i] == float('inf'):
                continue

            node = root
            for j in range(i, n):
                char = target[j]
                if char not in node.children:
                    break
                node = node.children[char]
                if node.min_cost_ending_here != float('inf'):
                    dp[j + 1] = min(dp[j + 1], dp[i] + node.min_cost_ending_here)

        result = dp[n]
        return result if result != float('inf') else -1
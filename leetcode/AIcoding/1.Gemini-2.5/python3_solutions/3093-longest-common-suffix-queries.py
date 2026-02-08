class TrieNode:
    def __init__(self):
        self.children = {}
        self.min_info = (float('inf'), float('inf'))

class Solution:
    def longestCommonSuffixQueries(self, words: list[str], queries: list[str]) -> list[int]:
        root = TrieNode()

        for i, word in enumerate(words):
            curr = root
            curr.min_info = min(curr.min_info, (len(word), i))

            for char in reversed(word):
                if char not in curr.children:
                    curr.children[char] = TrieNode()
                curr = curr.children[char]
                curr.min_info = min(curr.min_info, (len(word), i))

        results = []
        for query in queries:
            curr = root
            best_match_index = -1

            if curr.min_info != (float('inf'), float('inf')):
                best_match_index = curr.min_info[1]

            for char in reversed(query):
                if char in curr.children:
                    curr = curr.children[char]
                    if curr.min_info != (float('inf'), float('inf')):
                        best_match_index = curr.min_info[1]
                else:
                    break
            results.append(best_match_index)

        return results
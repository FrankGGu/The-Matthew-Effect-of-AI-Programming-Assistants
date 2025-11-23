class Solution:
    def twoEditWords(self, queries: List[str], dictionary: List[str]) -> List[str]:
        def is_two_edits_away(word1, word2):
            count = 0
            for a, b in zip(word1, word2):
                if a != b:
                    count += 1
                    if count > 2:
                        return False
            return count <= 2

        result = []
        for query in queries:
            if any(is_two_edits_away(query, word) for word in dictionary):
                result.append(query)
        return result
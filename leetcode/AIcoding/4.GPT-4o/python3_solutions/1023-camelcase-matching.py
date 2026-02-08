class Solution:
    def camelMatch(self, queries: List[str], pattern: str) -> List[bool]:
        def isMatch(query: str) -> bool:
            i, j = 0, 0
            while i < len(query) and j < len(pattern):
                if query[i] == pattern[j]:
                    i += 1
                    j += 1
                elif query[i].isupper():
                    return False
                else:
                    i += 1
            while i < len(query):
                if query[i].isupper():
                    return False
                i += 1
            return j == len(pattern)

        return [isMatch(query) for query in queries]
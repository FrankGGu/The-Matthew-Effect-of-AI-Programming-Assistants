class Solution:
    def camelMatch(self, queries: List[str], pattern: str) -> List[bool]:
        def match(query: str, pattern: str) -> bool:
            i, j = 0, 0
            while i < len(query):
                if j < len(pattern) and query[i] == pattern[j]:
                    i += 1
                    j += 1
                elif query[i].isupper():
                    return False
                else:
                    i += 1
            return j == len(pattern)

        result = []
        for query in queries:
            result.append(match(query, pattern))
        return result
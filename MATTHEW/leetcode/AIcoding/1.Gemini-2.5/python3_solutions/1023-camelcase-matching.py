class Solution:
    def camelMatch(self, queries: List[str], pattern: str) -> List[bool]:

        def check(query: str, pattern: str) -> bool:
            p_ptr = 0
            for q_char in query:
                if p_ptr < len(pattern) and q_char == pattern[p_ptr]:
                    p_ptr += 1
                elif q_char.isupper():
                    return False
            return p_ptr == len(pattern)

        result = []
        for query in queries:
            result.append(check(query, pattern))
        return result
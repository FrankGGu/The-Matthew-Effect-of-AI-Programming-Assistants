class Solution:
    def canMakePaliQueries(self, s: str, queries: List[List[int]]) -> List[bool]:
        from collections import Counter

        n = len(s)
        prefix_count = [Counter()]
        for char in s:
            prefix_count.append(prefix_count[-1] + Counter(char))

        result = []
        for start, end, k in queries:
            char_count = prefix_count[end + 1] - prefix_count[start]
            odd_count = sum(1 for count in char_count.values() if count % 2 == 1)
            result.append(odd_count // 2 <= k)

        return result
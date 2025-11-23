class Solution:
    def canMakePaliQueries(self, s: str, queries: List[List[int]]) -> List[bool]:
        from collections import Counter

        n = len(s)
        prefix_count = [Counter()]
        current_count = Counter()

        for char in s:
            current_count[char] += 1
            prefix_count.append(current_count.copy())

        result = []
        for start, end, k in queries:
            char_count = prefix_count[end + 1] - prefix_count[start]
            odd_count = sum(1 for count in char_count.values() if count % 2 == 1)
            result.append(odd_count // 2 <= k)

        return result
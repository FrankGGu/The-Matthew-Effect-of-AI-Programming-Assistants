class Solution:
    def substringXorQueries(self, s: str, queries: List[List[int]]) -> List[List[int]]:
        n = len(s)
        max_len = 30
        result = []

        xor_map = {}
        for length in range(1, max_len + 1):
            for i in range(n - length + 1):
                sub_xor = int(s[i:i + length], 2)
                if sub_xor not in xor_map:
                    xor_map[sub_xor] = (i, i + length - 1)

        for x, y in queries:
            if x ^ y in xor_map:
                result.append(list(xor_map[x ^ y]))
            else:
                result.append([-1, -1])

        return result
class Solution:
    def substringXOR(self, s: str, queries: list[list[int]]) -> list[int]:
        from collections import defaultdict

        n = len(s)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] ^ (1 << int(s[i]))

        result = []
        for a, b in queries:
            target = a ^ b
            seen = defaultdict(int)
            seen[0] = 0
            for i in range(1, n + 1):
                if prefix[i] ^ target in seen:
                    result.append(i - seen[prefix[i] ^ target])
                    break
                seen[prefix[i]] = i
            else:
                result.append(-1)

        return result
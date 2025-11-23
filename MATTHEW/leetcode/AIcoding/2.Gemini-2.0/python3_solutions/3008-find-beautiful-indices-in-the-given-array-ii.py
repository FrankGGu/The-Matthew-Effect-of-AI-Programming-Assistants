class Solution:
    def beautifulIndices(self, s: str, a: str, b: str, k: int) -> list[int]:
        n = len(s)
        len_a = len(a)
        len_b = len(b)
        indices_a = []
        indices_b = []

        for i in range(n - len_a + 1):
            if s[i:i+len_a] == a:
                indices_a.append(i)

        for i in range(n - len_b + 1):
            if s[i:i+len_b] == b:
                indices_b.append(i)

        result = []
        for i in indices_a:
            for j in indices_b:
                if abs(i - j) <= k:
                    result.append(i)
                    break

        return sorted(list(set(result)))
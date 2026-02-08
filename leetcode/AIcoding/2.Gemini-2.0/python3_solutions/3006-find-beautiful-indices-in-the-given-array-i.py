class Solution:
    def beautifulIndices(self, s: str, a: str, b: str, k: int) -> List[int]:
        indices_a = []
        indices_b = []
        for i in range(len(s) - len(a) + 1):
            if s[i:i+len(a)] == a:
                indices_a.append(i)
        for i in range(len(s) - len(b) + 1):
            if s[i:i+len(b)] == b:
                indices_b.append(i)

        result = []
        for i in indices_a:
            found = False
            for j in indices_b:
                if abs(i - j) <= k:
                    found = True
                    break
            if found:
                result.append(i)

        return result
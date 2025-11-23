class Solution:
    def matchReplacement(self, s: str, sub: str, mappings: list[list[str]]) -> bool:
        m = len(s)
        n = len(sub)
        if n > m:
            return False

        mapping_dict = {}
        for a, b in mappings:
            if a not in mapping_dict:
                mapping_dict[a] = set()
            mapping_dict[a].add(b)

        for i in range(m - n + 1):
            match = True
            for j in range(n):
                if s[i + j] == sub[j]:
                    continue
                if sub[j] in mapping_dict and s[i + j] in mapping_dict[sub[j]]:
                    continue
                match = False
                break
            if match:
                return True

        return False
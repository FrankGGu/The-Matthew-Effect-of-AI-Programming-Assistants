class Solution:
    def matchReplacement(self, s: str, sub: str, mappings: List[List[str]]) -> bool:
        from collections import defaultdict
        map_dict = defaultdict(set)
        for old, new in mappings:
            map_dict[old].add(new)

        n = len(s)
        m = len(sub)

        for i in range(n - m + 1):
            match = True
            for j in range(m):
                s_char = s[i + j]
                sub_char = sub[j]
                if s_char == sub_char:
                    continue
                if s_char in map_dict.get(sub_char, set()):
                    continue
                match = False
                break
            if match:
                return True
        return False
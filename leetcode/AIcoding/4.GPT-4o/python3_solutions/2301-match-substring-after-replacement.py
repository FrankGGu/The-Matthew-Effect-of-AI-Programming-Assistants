class Solution:
    def matchReplacement(self, s: str, sub: str, mappings: List[List[str]]) -> bool:
        mapping_dict = {}
        for a, b in mappings:
            if a not in mapping_dict:
                mapping_dict[a] = set()
            mapping_dict[a].add(b)

        for i in range(len(s) - len(sub) + 1):
            if self.is_match(s[i:i + len(sub)], sub, mapping_dict):
                return True
        return False

    def is_match(self, s_sub: str, sub: str, mapping_dict: dict) -> bool:
        for s_char, sub_char in zip(s_sub, sub):
            if s_char != sub_char and s_char not in mapping_dict or sub_char not in mapping_dict[s_char]:
                return False
        return True
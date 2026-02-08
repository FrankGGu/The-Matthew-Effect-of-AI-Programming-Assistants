class Solution:
    def canConvert(self, str1: str, str2: str) -> bool:
        if str1 == str2:
            return True
        conversion_map = {}
        unique_characters_str2 = set()

        for c1, c2 in zip(str1, str2):
            if c1 in conversion_map:
                if conversion_map[c1] != c2:
                    return False
            else:
                conversion_map[c1] = c2
                unique_characters_str2.add(c2)

        return len(unique_characters_str2) < 26
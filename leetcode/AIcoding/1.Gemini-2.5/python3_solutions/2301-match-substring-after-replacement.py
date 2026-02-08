class Solution:
    def matchReplacement(self, s: str, sub: str, mappings: list[list[str]]) -> bool:
        replacements = {}
        for char1, char2 in mappings:
            if char1 not in replacements:
                replacements[char1] = set()
            replacements[char1].add(char2)

        n = len(s)
        m = len(sub)

        for i in range(n - m + 1):
            is_match_candidate = True
            for j in range(m):
                s_char = s[i + j]
                sub_char = sub[j]

                if s_char == sub_char:
                    continue
                else:
                    if sub_char in replacements and s_char in replacements[sub_char]:
                        continue
                    else:
                        is_match_candidate = False
                        break

            if is_match_candidate:
                return True

        return False
class Solution:
    def findAndReplacePattern(self, words: List[str], pattern: str) -> List[str]:
        def matches(word, pattern):
            mapping_w_to_p = {}
            mapping_p_to_w = {}
            for w_char, p_char in zip(word, pattern):
                if w_char not in mapping_w_to_p:
                    mapping_w_to_p[w_char] = p_char
                if p_char not in mapping_p_to_w:
                    mapping_p_to_w[p_char] = w_char
                if mapping_w_to_p[w_char] != p_char or mapping_p_to_w[p_char] != w_char:
                    return False
            return True

        return [word for word in words if matches(word, pattern)]
class Solution:
    def prefixCount(self, words: List[str], pref: str) -> int:
        count = 0
        len_pref = len(pref)
        for word in words:
            if len(word) >= len_pref and word[:len_pref] == pref:
                count += 1
        return count
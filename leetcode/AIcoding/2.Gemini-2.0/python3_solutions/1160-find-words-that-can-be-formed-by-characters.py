from collections import Counter

class Solution:
    def countCharacters(self, words: List[str], chars: str) -> int:
        char_count = Counter(chars)
        ans = 0
        for word in words:
            word_count = Counter(word)
            flag = True
            for char, count in word_count.items():
                if char not in char_count or count > char_count[char]:
                    flag = False
                    break
            if flag:
                ans += len(word)
        return ans
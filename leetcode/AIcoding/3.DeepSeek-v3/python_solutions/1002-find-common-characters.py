class Solution:
    def commonChars(self, words: List[str]) -> List[str]:
        if not words:
            return []

        common = list(words[0])

        for word in words[1:]:
            temp = []
            for char in word:
                if char in common:
                    temp.append(char)
                    common.remove(char)
            common = temp

        return common
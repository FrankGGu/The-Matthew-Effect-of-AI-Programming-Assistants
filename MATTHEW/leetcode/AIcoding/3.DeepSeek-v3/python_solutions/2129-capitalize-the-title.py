class Solution:
    def capitalizeTitle(self, title: str) -> str:
        words = title.split()
        for i in range(len(words)):
            word = words[i]
            if len(word) <= 2:
                words[i] = word.lower()
            else:
                words[i] = word.capitalize()
        return ' '.join(words)
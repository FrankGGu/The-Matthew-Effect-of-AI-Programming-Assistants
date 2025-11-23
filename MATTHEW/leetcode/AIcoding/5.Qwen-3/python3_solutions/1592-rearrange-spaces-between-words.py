class Solution:
    def reorderSpaces(self, text: str) -> str:
        words = text.split()
        space_count = text.count(' ')
        if len(words) == 1:
            return words[0] + ' ' * space_count
        gap = space_count // (len(words) - 1)
        remainder = space_count % (len(words) - 1)
        result = (' ' * gap).join(words)
        return result + ' ' * remainder
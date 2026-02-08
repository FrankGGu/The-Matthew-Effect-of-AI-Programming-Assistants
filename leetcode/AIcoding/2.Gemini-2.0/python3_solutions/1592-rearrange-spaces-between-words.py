class Solution:
    def reorderSpaces(self, text: str) -> str:
        words = text.split()
        space_count = text.count(' ')
        word_count = len(words)

        if word_count == 1:
            return words[0] + ' ' * space_count

        space_between = space_count // (word_count - 1)
        trailing_space = space_count % (word_count - 1)

        return (' ' * space_between).join(words) + ' ' * trailing_space
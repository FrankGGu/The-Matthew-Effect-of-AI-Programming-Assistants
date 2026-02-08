class Solution:
    def reorderSpaces(self, text: str) -> str:
        total_spaces = text.count(' ')
        words = text.split()
        num_words = len(words)

        if num_words == 1:
            return words[0] + ' ' * total_spaces

        spaces_between_words = total_spaces // (num_words - 1)
        trailing_spaces = total_spaces % (num_words - 1)

        result = (' ' * spaces_between_words).join(words)
        result += ' ' * trailing_spaces

        return result
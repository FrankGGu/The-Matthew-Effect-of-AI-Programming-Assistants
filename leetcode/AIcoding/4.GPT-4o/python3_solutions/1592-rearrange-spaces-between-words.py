class Solution:
    def rearrangeSpaces(self, text: str) -> str:
        words = text.split()
        space_count = text.count(' ')
        if len(words) == 1:
            return words[0] + ' ' * space_count
        gaps = len(words) - 1
        space_between = space_count // gaps
        extra_spaces = space_count % gaps
        return (' ' * space_between).join(words) + ' ' * extra_spaces
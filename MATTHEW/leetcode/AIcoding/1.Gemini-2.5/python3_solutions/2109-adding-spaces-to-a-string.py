class Solution:
    def addSpaces(self, s: str, spaces: list[int]) -> str:
        result = []
        space_ptr = 0
        s_len = len(s)
        spaces_len = len(spaces)

        for i in range(s_len):
            if space_ptr < spaces_len and i == spaces[space_ptr]:
                result.append(' ')
                space_ptr += 1
            result.append(s[i])

        return "".join(result)
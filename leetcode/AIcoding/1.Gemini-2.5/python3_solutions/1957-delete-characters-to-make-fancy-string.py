class Solution:
    def makeFancyString(self, s: str) -> str:
        fancy_s = []
        for char in s:
            if len(fancy_s) < 2:
                fancy_s.append(char)
            elif not (char == fancy_s[-1] and char == fancy_s[-2]):
                fancy_s.append(char)
        return "".join(fancy_s)
class Solution:
    def findReplaceString(self, s: str, indices: list[int], sources: list[str], targets: list[str]) -> str:
        replacements = []
        for i in range(len(indices)):
            replacements.append((indices[i], sources[i], targets[i]))

        replacements.sort()

        result = ""
        curr_index = 0
        for index, source, target in replacements:
            result += s[curr_index:index]
            if s[index:index + len(source)] == source:
                result += target
                curr_index = index + len(source)
            else:
                result += s[index:index + len(source)]
                curr_index = index

        result += s[curr_index:]
        return result
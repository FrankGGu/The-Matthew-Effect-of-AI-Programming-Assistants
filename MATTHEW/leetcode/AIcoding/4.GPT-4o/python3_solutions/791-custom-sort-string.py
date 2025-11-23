class Solution:
    def customSortString(self, order: str, s: str) -> str:
        count = {}
        for char in s:
            count[char] = count.get(char, 0) + 1

        result = []
        for char in order:
            if char in count:
                result.append(char * count[char])
                del count[char]

        for char in count:
            result.append(char * count[char])

        return ''.join(result)
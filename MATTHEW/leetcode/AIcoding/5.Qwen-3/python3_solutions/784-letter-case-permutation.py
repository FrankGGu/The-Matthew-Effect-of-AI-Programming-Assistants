from typing import List

class Solution:
    def letterCasePermutation(self, s: str) -> List[str]:
        result = []
        def backtrack(index, path):
            if index == len(s):
                result.append(''.join(path))
                return
            if s[index].isdigit():
                backtrack(index + 1, path + [s[index]])
            else:
                backtrack(index + 1, path + [s[index].lower()])
                backtrack(index + 1, path + [s[index].upper()])
        backtrack(0, [])
        return result
class Solution:
    def generateBinaryStrings(self, n: int) -> List[str]:
        res = []

        def backtrack(current, last_char):
            if len(current) == n:
                res.append(current)
                return
            backtrack(current + '1', '1')
            if last_char != '0':
                backtrack(current + '0', '0')

        backtrack("", "")
        return res
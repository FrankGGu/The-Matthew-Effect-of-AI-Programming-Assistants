class Solution:
    def generateBinaryStrings(self, n: int) -> List[str]:
        result = []

        def backtrack(current, prev_zero):
            if len(current) == n:
                result.append(current)
                return
            backtrack(current + '1', False)
            if not prev_zero:
                backtrack(current + '0', True)

        backtrack('', False)
        return result
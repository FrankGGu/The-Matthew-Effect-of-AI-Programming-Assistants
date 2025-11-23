class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        def backtrack(current, open_count, close_count, result):
            if len(current) == 2 * n:
                result.append(current)
                return
            if open_count < n:
                backtrack(current + '(', open_count + 1, close_count, result)
            if close_count < open_count:
                backtrack(current + ')', open_count, close_count + 1, result)

        result = []
        backtrack("", 0, 0, result)
        return result
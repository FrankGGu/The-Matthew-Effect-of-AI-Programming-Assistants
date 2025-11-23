class Solution:
    def addOperators(self, num: str, target: int) -> List[str]:
        result = []

        def backtrack(start, path, total, prev):
            if start == len(num):
                if total == target:
                    result.append(''.join(path))
                return
            for end in range(start + 1, len(num) + 1):
                s = num[start:end]
                if len(s) > 1 and s[0] == '0':
                    continue
                curr = int(s)
                if start == 0:
                    backtrack(end, path + [s], curr, curr)
                else:
                    backtrack(end, path + ['+', s], total + curr, curr)
                    backtrack(end, path + ['-', s], total - curr, -curr)
                    backtrack(end, path + ['*', s], total - prev + prev * curr, prev * curr)

        backtrack(0, [], 0, 0)
        return result
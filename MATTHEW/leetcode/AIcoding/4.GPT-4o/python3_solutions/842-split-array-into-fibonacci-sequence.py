class Solution:
    def splitIntoFibonacci(self, S: str) -> List[int]:
        def backtrack(start, path):
            if start == len(S) and len(path) >= 3:
                return path
            for i in range(start, len(S)):
                if S[start] == '0' and i > start:
                    break
                num = int(S[start:i + 1])
                if num > 2 ** 31 - 1:
                    break
                if len(path) < 2 or path[-1] + path[-2] == num:
                    res = backtrack(i + 1, path + [num])
                    if res:
                        return res
            return []

        return backtrack(0, [])
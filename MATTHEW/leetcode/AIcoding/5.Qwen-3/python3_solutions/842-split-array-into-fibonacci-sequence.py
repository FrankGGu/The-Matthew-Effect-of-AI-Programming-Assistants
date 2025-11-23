class Solution:
    def splitIntoFibonacci(self, num: str) -> List[int]:
        def backtrack(start, a, b, path):
            if start == len(num):
                return path[:]
            for i in range(start, len(num)):
                if num[start] == '0' and i > start:
                    break
                curr = int(num[start:i+1])
                if len(path) >= 2:
                    if curr > a + b:
                        break
                    if curr != a + b:
                        continue
                path.append(curr)
                if backtrack(i + 1, b, curr, path):
                    return path
                path.pop()
            return []

        return backtrack(0, 0, 0, [])
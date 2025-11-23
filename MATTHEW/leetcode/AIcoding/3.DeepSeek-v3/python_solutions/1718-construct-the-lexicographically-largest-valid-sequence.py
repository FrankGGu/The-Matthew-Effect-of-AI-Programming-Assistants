class Solution:
    def constructDistancedSequence(self, n: int) -> List[int]:
        size = 2 * n - 1
        res = [0] * size
        used = [False] * (n + 1)

        def backtrack(pos):
            if pos == size:
                return True
            if res[pos] != 0:
                return backtrack(pos + 1)
            for num in range(n, 0, -1):
                if used[num]:
                    continue
                if num == 1:
                    res[pos] = 1
                    used[1] = True
                    if backtrack(pos + 1):
                        return True
                    res[pos] = 0
                    used[1] = False
                else:
                    if pos + num >= size or res[pos + num] != 0:
                        continue
                    res[pos] = num
                    res[pos + num] = num
                    used[num] = True
                    if backtrack(pos + 1):
                        return True
                    res[pos] = 0
                    res[pos + num] = 0
                    used[num] = False
            return False

        backtrack(0)
        return res
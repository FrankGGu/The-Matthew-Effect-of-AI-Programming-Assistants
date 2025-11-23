class Solution:
    def constructDistancedSequence(self, n: int) -> list[int]:
        res = [0] * (2 * n - 1)
        used = [False] * (n + 1)

        def backtrack(index):
            if index == len(res):
                return True

            if res[index] != 0:
                return backtrack(index)

            for num in range(n, 0, -1):
                if used[num]:
                    continue

                if num == 1:
                    res[index] = num
                    used[num] = True
                    if backtrack(index + 1):
                        return True
                    used[num] = False
                    res[index] = 0
                elif index + num < len(res) and res[index + num] == 0:
                    res[index] = num
                    res[index + num] = num
                    used[num] = True
                    if backtrack(index + 1):
                        return True
                    used[num] = False
                    res[index] = 0
                    res[index + num] = 0

            return False

        backtrack(0)
        return res
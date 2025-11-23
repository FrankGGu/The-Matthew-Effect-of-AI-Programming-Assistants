class Solution:
    def constructDistancedSequence(self, n: int) -> list[int]:
        result = [0] * (2 * n - 1)
        used = [False] * (n + 1)

        def backtrack(index):
            if index == len(result):
                return True

            if result[index] != 0:
                return backtrack(index + 1)

            for num in range(n, 0, -1):
                if not used[num]:
                    if num == 1:
                        result[index] = num
                        used[num] = True
                        if backtrack(index + 1):
                            return True
                        used[num] = False
                        result[index] = 0
                    elif index + num < len(result) and result[index + num] == 0:
                        result[index] = num
                        result[index + num] = num
                        used[num] = True
                        if backtrack(index + 1):
                            return True
                        used[num] = False
                        result[index] = 0
                        result[index + num] = 0
            return False

        backtrack(0)
        return result
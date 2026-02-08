class Solution:
    def constructDistancedSequence(self, n: int) -> list[int]:
        length = 2 * n - 1
        sequence = [0] * length
        used = [False] * (n + 1)

        def backtrack(idx: int) -> bool:
            if idx == length:
                return True

            if sequence[idx] != 0:
                return backtrack(idx + 1)

            for num in range(n, 0, -1):
                if not used[num]:
                    if num == 1:
                        sequence[idx] = 1
                        used[1] = True
                        if backtrack(idx + 1):
                            return True
                        used[1] = False
                        sequence[idx] = 0
                    else:
                        pos2 = idx + num
                        if pos2 < length and sequence[pos2] == 0:
                            sequence[idx] = num
                            sequence[pos2] = num
                            used[num] = True
                            if backtrack(idx + 1):
                                return True
                            used[num] = False
                            sequence[idx] = 0
                            sequence[pos2] = 0
            return False

        backtrack(0)
        return sequence
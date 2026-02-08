class Solution:
    def findLexSmallestSequence(self, n: int) -> list[int]:
        length = 2 * n - 1
        ans = [0] * length
        used = [False] * (n + 1)

        def solve(idx: int) -> bool:
            if idx == length:
                return True

            if ans[idx] != 0:
                return solve(idx + 1)

            for num in range(1, n + 1):
                if num == 1:
                    if not used[1]:
                        ans[idx] = 1
                        used[1] = True
                        if solve(idx + 1):
                            return True
                        used[1] = False
                        ans[idx] = 0
                else:
                    if not used[num]:
                        pos2 = idx + num
                        if pos2 < length and ans[pos2] == 0:
                            ans[idx] = num
                            ans[pos2] = num
                            used[num] = True
                            if solve(idx + 1):
                                return True
                            used[num] = False
                            ans[idx] = 0
                            ans[pos2] = 0
            return False

        solve(0)
        return ans
class Solution:
    def minSwaps(self, grid: List[List[int]]) -> int:
        n = len(grid)
        zeros = []
        for row in grid:
            cnt = 0
            for num in reversed(row):
                if num == 0:
                    cnt += 1
                else:
                    break
            zeros.append(cnt)

        res = 0
        for i in range(n):
            target = n - 1 - i
            if zeros[i] >= target:
                continue
            found = -1
            for j in range(i + 1, n):
                if zeros[j] >= target:
                    found = j
                    break
            if found == -1:
                return -1
            res += found - i
            zeros[i+1:found+1] = zeros[i:found]
            zeros[i] = zeros[found]
        return res
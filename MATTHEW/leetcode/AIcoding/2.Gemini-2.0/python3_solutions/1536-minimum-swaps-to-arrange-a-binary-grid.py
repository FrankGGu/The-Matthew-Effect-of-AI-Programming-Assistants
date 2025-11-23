class Solution:
    def minSwaps(self, grid: List[List[int]]) -> int:
        n = len(grid)
        rights = []
        for row in grid:
            count = 0
            for i in range(n - 1, -1, -1):
                if row[i] == 1:
                    break
                count += 1
            rights.append(count)

        swaps = 0
        for i in range(n):
            req = n - 1 - i
            found = False
            for j in range(i, n):
                if rights[j] >= req:
                    for k in range(j, i, -1):
                        rights[k], rights[k - 1] = rights[k - 1], rights[k]
                        swaps += 1
                    found = True
                    break
            if not found:
                return -1

        return swaps
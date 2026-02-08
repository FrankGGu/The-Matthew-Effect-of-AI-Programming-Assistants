class Solution:
    def maxStudents(self, seats: List[List[str]]) -> int:
        m, n = len(seats), len(seats[0])
        dp = {}

        def solve(row, prev_mask):
            if row == m:
                return 0

            if (row, prev_mask) in dp:
                return dp[(row, prev_mask)]

            ans = 0
            for mask in range(1 << n):
                valid = True
                count = 0
                for i in range(n):
                    if (mask >> i) & 1:
                        if seats[row][i] == '#':
                            valid = False
                            break
                        count += 1
                        if i > 0 and ((mask >> (i - 1)) & 1):
                            valid = False
                            break

                if not valid:
                    continue

                valid = True
                for i in range(n):
                    if (mask >> i) & 1:
                        if i > 0 and ((prev_mask >> (i - 1)) & 1):
                            valid = False
                            break
                        if i < n - 1 and ((prev_mask >> (i + 1)) & 1):
                            valid = False
                            break

                if not valid:
                    continue

                ans = max(ans, count + solve(row + 1, mask))

            ans = max(ans, solve(row + 1, 0))

            dp[(row, prev_mask)] = ans
            return ans

        return solve(0, 0)
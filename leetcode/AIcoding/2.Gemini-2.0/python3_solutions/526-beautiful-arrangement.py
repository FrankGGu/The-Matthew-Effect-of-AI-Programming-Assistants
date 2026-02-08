class Solution:
    def countArrangement(self, n: int) -> int:
        def count(index, used):
            if index > n:
                return 1

            cnt = 0
            for i in range(1, n + 1):
                if not used[i] and (i % index == 0 or index % i == 0):
                    used[i] = True
                    cnt += count(index + 1, used)
                    used[i] = False
            return cnt

        used = [False] * (n + 1)
        return count(1, used)
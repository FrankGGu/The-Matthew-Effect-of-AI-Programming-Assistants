class Solution:
    def minimumSwaps(self, nums: List[int]) -> int:
        def digit_sum(x):
            s = 0
            while x > 0:
                s += x % 10
                x = x // 10
            return s

        n = len(nums)
        arr = [(digit_sum(num), i) for i, num in enumerate(nums)]
        arr.sort()
        visited = [False] * n
        res = 0

        for i in range(n):
            if visited[i] or arr[i][1] == i:
                continue
            cycle_size = 0
            j = i
            while not visited[j]:
                visited[j] = True
                j = arr[j][1]
                cycle_size += 1
            if cycle_size > 0:
                res += (cycle_size - 1)
        return res
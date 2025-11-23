class Solution:
    def minimumSwaps(self, nums: list[int]) -> int:
        def digit_sum(n: int) -> int:
            s = 0
            if n == 0:
                return 0
            while n > 0:
                s += n % 10
                n //= 10
            return s

        n = len(nums)

        indexed_nums = []
        for i in range(n):
            indexed_nums.append((digit_sum(nums[i]), nums[i], i))

        indexed_nums.sort()

        pos = [0] * n
        for i in range(n):
            original_index = indexed_nums[i][2]
            pos[original_index] = i

        visited = [False] * n
        swaps = 0

        for i in range(n):
            if visited[i] or pos[i] == i:
                continue

            cycle_size = 0
            j = i
            while not visited[j]:
                visited[j] = True
                j = pos[j]
                cycle_size += 1

            if cycle_size > 0:
                swaps += (cycle_size - 1)

        return swaps
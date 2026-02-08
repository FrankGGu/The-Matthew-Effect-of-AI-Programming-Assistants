class Solution:
    def minimumSwaps(self, nums: List[int]) -> int:
        def digit_sum(x):
            return sum(int(d) for d in str(x))

        indexed_nums = [(num, digit_sum(num), i) for i, num in enumerate(nums)]
        indexed_nums.sort(key=lambda x: (x[1], x[0]))

        visited = [False] * len(nums)
        swaps = 0

        for i in range(len(nums)):
            if visited[i] or indexed_nums[i][2] == i:
                continue

            cycle_size = 0
            j = i
            while not visited[j]:
                visited[j] = True
                j = indexed_nums[j][2]
                cycle_size += 1

            if cycle_size > 0:
                swaps += cycle_size - 1

        return swaps
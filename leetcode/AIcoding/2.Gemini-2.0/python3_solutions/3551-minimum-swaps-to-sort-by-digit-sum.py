class Solution:
    def minimumSwaps(self, nums: List[int]) -> int:
        def digit_sum(n):
            s = 0
            while n > 0:
                s += n % 10
                n //= 10
            return s

        n = len(nums)
        sums = [digit_sum(num) for num in nums]
        indices = list(range(n))
        indices.sort(key=lambda i: sums[i])

        visited = [False] * n
        swaps = 0

        for i in range(n):
            if visited[i] or indices[i] == i:
                continue

            cycle_size = 0
            j = i
            while not visited[j]:
                visited[j] = True
                j = indices[j]
                cycle_size += 1

            swaps += cycle_size - 1

        return swaps
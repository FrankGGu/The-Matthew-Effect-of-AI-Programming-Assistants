class Solution:
    def countLargestGroup(self, n: int) -> int:
        def digit_sum(num):
            s = 0
            while num > 0:
                s += num % 10
                num = num // 10
            return s

        groups = {}
        for i in range(1, n + 1):
            s = digit_sum(i)
            if s in groups:
                groups[s] += 1
            else:
                groups[s] = 1

        max_size = max(groups.values())
        count = sum(1 for size in groups.values() if size == max_size)
        return count
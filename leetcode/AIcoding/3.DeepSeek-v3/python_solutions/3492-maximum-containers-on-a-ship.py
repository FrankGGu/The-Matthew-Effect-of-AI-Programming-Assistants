class Solution:
    def maxContainers(self, N: int, K: int) -> int:
        total = 0
        containers = 0
        while N >= K:
            new_containers = N // K
            total += new_containers
            N = N % K + new_containers
        return total
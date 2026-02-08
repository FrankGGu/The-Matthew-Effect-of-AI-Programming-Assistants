class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n + 1))  # 1-indexed
        self.rank = [0] * (n + 1)

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)

        if root_i != root_j:
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            return True
        return False

class Solution:
    def gcdSort(self, nums: list[int]) -> bool:
        max_val = max(nums)

        # Sieve to find smallest prime factor for each number up to max_val
        # min_prime_factor[i] stores the smallest prime factor of i
        # If min_prime_factor[i] == i, then i is prime.
        min_prime_factor = list(range(max_val + 1))
        for i in range(2, int(max_val**0.5) + 1):
            if min_prime_factor[i] == i:  # i is prime
                for multiple in range(i * i, max_val + 1, i):
                    if min_prime_factor[multiple] == multiple:  # Only update if not already found a smaller prime factor
                        min_prime_factor[multiple] = i

        # Function to get all unique prime factors of a number
        def get_prime_factors(n):
            factors = set()
            if n <= 1:
                return factors

            temp_n = n
            while temp_n > 1:
                factor = min_prime_factor[temp_n]
                factors.add(factor)
                temp_n //= factor
            return factors

        uf = UnionFind(max_val)

        # Connect each number in nums to its prime factors using Union-Find.
        # This effectively connects any two numbers that share a common prime factor.
        for num in nums:
            if num > 1:  # 1 has no prime factors and cannot be swapped with any other number
                factors = get_prime_factors(num)
                for factor in factors:
                    uf.union(num, factor)

        # Sort the original array to get the target configuration
        sorted_nums = sorted(nums)

        # Check if each number in the original array can reach its position in the sorted array.
        # This is true if nums[i] and sorted_nums[i] belong to the same connected component.
        for i in range(len(nums)):
            if uf.find(nums[i]) != uf.find(sorted_nums[i]):
                return False

        return True
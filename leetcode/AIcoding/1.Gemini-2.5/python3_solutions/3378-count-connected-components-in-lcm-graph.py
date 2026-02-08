class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.size = [1] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            if self.size[root_i] < self.size[root_j]:
                root_i, root_j = root_j, root_i
            self.parent[root_j] = root_i
            self.size[root_i] += self.size[root_j]
            return True
        return False

class Solution:
    def countComponents(self, nums: list[int]) -> int:
        if not nums:
            return 0

        max_val = 0
        for num in nums:
            max_val = max(max_val, num)

        # Sieve for smallest prime factor (SPF)
        # spf[i] will store the smallest prime factor of i
        # Initialize with 0, meaning not yet processed or prime itself
        spf = [0] * (max_val + 1)
        for i in range(2, max_val + 1):
            if spf[i] == 0:  # i is prime
                for j in range(i, max_val + 1, i):
                    if spf[j] == 0:
                        spf[j] = i

        dsu = DSU(max_val + 1)

        unique_nums = set()
        has_one = False
        for num in nums:
            if num == 1:
                has_one = True
            unique_nums.add(num)

        for num in unique_nums:
            if num == 1:
                continue

            temp_num = num
            while temp_num > 1:
                prime_factor = spf[temp_num]
                dsu.union(num, prime_factor)
                # Divide out all occurrences of this prime factor
                while temp_num % prime_factor == 0:
                    temp_num //= prime_factor

        num_components = 0
        seen_roots = set()

        for num in unique_nums:
            if num == 1:
                continue

            root = dsu.find(num)
            if root not in seen_roots:
                seen_roots.add(root)
                num_components += 1

        if has_one:
            num_components += 1

        return num_components
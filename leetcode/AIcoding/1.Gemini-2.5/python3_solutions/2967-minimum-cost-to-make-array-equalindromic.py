import bisect

class Solution:
    _all_palindromes = []

    def _generate_palindromes(self, limit):
        palindromes = set()

        for i in range(1, 100000):
            s = str(i)

            p_even_str = s + s[::-1]
            p_even = int(p_even_str)
            if p_even <= limit:
                palindromes.add(p_even)

            p_odd_str = s + s[:-1][::-1]
            p_odd = int(p_odd_str)
            if p_odd <= limit:
                palindromes.add(p_odd)

        return sorted(list(palindromes))

    def _calculate_cost(self, nums, p):
        cost = 0
        for num in nums:
            cost += abs(num - p)
        return cost

    def minimumCost(self, nums: list[int]) -> int:
        if not Solution._all_palindromes:
            Solution._all_palindromes = self._generate_palindromes(10**9)

        nums.sort()
        n = len(nums)

        median_candidates_values = []
        median_candidates_values.append(nums[n // 2])
        if n % 2 == 0:
            median_candidates_values.append(nums[n // 2 - 1])

        candidate_palindromes = set()
        for m_val in median_candidates_values:
            idx = bisect.bisect_left(Solution._all_palindromes, m_val)

            if idx < len(Solution._all_palindromes):
                candidate_palindromes.add(Solution._all_palindromes[idx])

            if idx > 0:
                candidate_palindromes.add(Solution._all_palindromes[idx-1])

        min_total_cost = float('inf')
        for p in candidate_palindromes:
            min_total_cost = min(min_total_cost, self._calculate_cost(nums, p))

        return min_total_cost
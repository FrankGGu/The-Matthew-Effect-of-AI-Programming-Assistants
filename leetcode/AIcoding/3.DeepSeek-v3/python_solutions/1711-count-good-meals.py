class Solution:
    def countPairs(self, deliciousness: List[int]) -> int:
        from collections import defaultdict
        MOD = 10**9 + 7
        max_sum = max(deliciousness) * 2
        power_of_two = set()
        num = 1
        while num <= max_sum:
            power_of_two.add(num)
            num <<= 1

        freq = defaultdict(int)
        res = 0
        for num in deliciousness:
            for p in power_of_two:
                res += freq.get(p - num, 0)
            freq[num] += 1
        return res % MOD
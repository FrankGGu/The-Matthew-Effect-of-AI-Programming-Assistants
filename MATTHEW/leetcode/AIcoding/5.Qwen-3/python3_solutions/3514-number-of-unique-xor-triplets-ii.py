class Solution:
    def countTriplets(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = 0
        xor_map = defaultdict(int)

        for num in nums:
            temp = defaultdict(int)
            for key in xor_map:
                temp[key ^ num] += xor_map[key]
            for key in temp:
                xor_map[key] += temp[key]
            xor_map[num] += 1

        for v in xor_map.values():
            count += v * (v - 1) // 2

        return count
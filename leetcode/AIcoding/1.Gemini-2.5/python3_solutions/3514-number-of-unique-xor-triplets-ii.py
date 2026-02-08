import collections

class Solution:
    def uniqueXORTriplets(self, nums: list[int]) -> int:
        n = len(nums)
        counts = collections.Counter(nums)
        unique_triplets = set()

        for i in range(n):
            for j in range(i + 1, n):
                a = nums[i]
                b = nums[j]
                c_target = a ^ b

                counts[a] -= 1
                counts[b] -= 1

                if c_target in counts and counts[c_target] > 0:
                    triplet = tuple(sorted((a, b, c_target)))
                    unique_triplets.add(triplet)

                counts[a] += 1
                counts[b] += 1

        return len(unique_triplets)
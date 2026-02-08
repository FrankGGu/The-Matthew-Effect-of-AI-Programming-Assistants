class Solution:
    def numTriplets(self, nums1: List[int], nums2: List[int]) -> int:
        from collections import defaultdict

        def countTriplets(numsA, numsB):
            count = 0
            freq = defaultdict(int)
            for num in numsB:
                freq[num] += 1

            for a in numsA:
                target = a * a
                seen = defaultdict(int)
                for b in numsB:
                    if target % b == 0:
                        c = target // b
                        if c in freq:
                            if c == b:
                                count += (freq[c] - seen[c] - 1)
                            else:
                                count += (freq[c] - seen[c])
                    seen[b] += 1
            return count

        return countTriplets(nums1, nums2) + countTriplets(nums2, nums1)
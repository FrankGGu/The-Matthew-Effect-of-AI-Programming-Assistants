class Solution:
    def minimumAddedInteger(self, nums1: List[int], nums2: List[int]) -> int:
        nums1.sort()
        nums2.sort()
        from collections import defaultdict

        def check(diff):
            i = 0
            j = 0
            skipped = 0
            while i < len(nums1) and j < len(nums2):
                if nums1[i] + diff == nums2[j]:
                    i += 1
                    j += 1
                else:
                    skipped += 1
                    i += 1
                    if skipped > 2:
                        return False
            return j == len(nums2)

        possible_diffs = set()
        for i in range(3):
            for j in range(3):
                if i < len(nums1) and j < len(nums2):
                    diff = nums2[j] - nums1[i]
                    possible_diffs.add(diff)

        for diff in sorted(possible_diffs):
            if check(diff):
                return diff

        return 0
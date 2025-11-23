class Solution:
    def minOperations(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)

        def solve(swap_first):
            ops = 0
            temp_nums1 = nums1[:]
            temp_nums2 = nums2[:]

            if swap_first:
                temp_nums1[0], temp_nums2[0] = temp_nums2[0], temp_nums1[0]
                ops += 1

            for i in range(1, n):
                if temp_nums1[i] <= temp_nums1[0] and temp_nums2[i] <= temp_nums2[0]:
                    continue
                elif temp_nums1[i] <= temp_nums2[0] and temp_nums2[i] <= temp_nums1[0]:
                    temp_nums1[i], temp_nums2[i] = temp_nums2[i], temp_nums1[i]
                    ops += 1
                    if temp_nums1[i] <= temp_nums1[0] and temp_nums2[i] <= temp_nums2[0]:
                        continue
                    else:
                        return float('inf')
                else:
                    return float('inf')

            return ops

        res = min(solve(False), solve(True))

        if res == float('inf'):
            return -1
        else:
            return res
class Solution:
    def advantageShuffle(self, nums1: list[int], nums2: list[int]) -> list[int]:
        n = len(nums1)

        nums1.sort()

        indexed_nums2 = []
        for i in range(n):
            indexed_nums2.append((nums2[i], i))
        indexed_nums2.sort()

        result = [0] * n

        left_a = 0
        right_a = n - 1

        left_b = 0
        right_b = n - 1

        while left_b <= right_b:
            if nums1[right_a] > indexed_nums2[right_b][0]:
                result[indexed_nums2[right_b][1]] = nums1[right_a]
                right_a -= 1
                right_b -= 1
            else:
                result[indexed_nums2[right_b][1]] = nums1[left_a]
                left_a += 1
                right_b -= 1

        return result
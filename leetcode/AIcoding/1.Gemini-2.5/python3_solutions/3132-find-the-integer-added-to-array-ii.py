class Solution:
    def findAddedInteger(self, nums1: list[int], nums2: list[int]) -> list[int]:
        n_original = len(nums1)
        nums1.sort()
        nums2.sort()

        possible_x_values = set()

        for i in range(n_original):
            for j in range(i + 1, n_original):
                temp_nums1 = []
                for k in range(n_original):
                    if k != i and k != j:
                        temp_nums1.append(nums1[k])

                x_candidate = nums2[0] - temp_nums1[0]

                is_valid_x = True
                for k_sub in range(1, len(nums2)):
                    if nums2[k_sub] - temp_nums1[k_sub] != x_candidate:
                        is_valid_x = False
                        break

                if is_valid_x:
                    possible_x_values.add(x_candidate)

        result = list(possible_x_values)
        result.sort()
        return result
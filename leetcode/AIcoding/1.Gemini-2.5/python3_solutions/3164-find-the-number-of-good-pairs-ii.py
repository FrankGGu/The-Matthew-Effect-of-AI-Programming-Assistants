class Solution:
    def numberOfGoodPairs(self, nums1: list[int], nums2: list[int], k: int) -> int:
        MAX_VAL = 1000000

        freq_nums1 = [0] * (MAX_VAL + 1)
        for num in nums1:
            freq_nums1[num] += 1

        freq_nums2 = [0] * (MAX_VAL + 1)
        for num in nums2:
            freq_nums2[num] += 1

        total_good_pairs = 0

        for num2_val in range(1, MAX_VAL + 1):
            if freq_nums2[num2_val] == 0:
                continue

            required_product_base = num2_val * k

            if required_product_base > MAX_VAL:
                continue

            for num1_val_multiple in range(required_product_base, MAX_VAL + 1, required_product_base):
                total_good_pairs += freq_nums1[num1_val_multiple] * freq_nums2[num2_val]

        return total_good_pairs
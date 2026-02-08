class Solution:
    def minOperations(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)

        diff = [0] * n
        sum_diff = 0

        for i in range(n):
            diff[i] = nums1[i] - nums2[i]
            sum_diff += diff[i]

        if sum_diff != 0:
            return -1

        pos_diffs = []
        neg_diffs = []

        for d in diff:
            if d > 0:
                pos_diffs.append(d)
            elif d < 0:
                neg_diffs.append(d)

        operations = 0
        p_ptr = 0
        n_ptr = 0

        while p_ptr < len(pos_diffs) and n_ptr < len(neg_diffs):
            current_pos_val = pos_diffs[p_ptr]
            current_neg_val = neg_diffs[n_ptr]

            transfer_amount = min(current_pos_val, -current_neg_val)

            operations += 1

            pos_diffs[p_ptr] -= transfer_amount
            neg_diffs[n_ptr] += transfer_amount

            if pos_diffs[p_ptr] == 0:
                p_ptr += 1
            if neg_diffs[n_ptr] == 0:
                n_ptr += 1

        return operations
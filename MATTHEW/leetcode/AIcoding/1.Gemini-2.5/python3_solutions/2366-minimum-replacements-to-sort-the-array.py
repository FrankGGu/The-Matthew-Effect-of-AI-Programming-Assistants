class Solution:
    def minimumReplacements(self, nums: list[int]) -> int:
        n = len(nums)
        replacements = 0

        last_val = nums[n - 1] 

        for i in range(n - 2, -1, -1):
            current_num = nums[i]

            if current_num <= last_val:
                last_val = current_num
            else:
                # Calculate the number of pieces 'k' current_num needs to be split into.
                # To minimize replacements, we want to minimize 'k'.
                # Each piece must be less than or equal to last_val.
                # So, k * last_val >= current_num.
                # The minimum integer k is ceil(current_num / last_val).
                k = (current_num + last_val - 1) // last_val

                # Add the number of replacements (k - 1)
                replacements += (k - 1)

                # After splitting current_num into 'k' pieces, say p_1, p_2, ..., p_k.
                # The array segment becomes ..., nums[i-1], p_1, p_2, ..., p_k, ...
                # For the array to be sorted, nums[i-1] must be <= p_1.
                # To make it easiest for nums[i-1], we want p_1 to be as large as possible.
                # When splitting current_num into 'k' pieces as evenly as possible,
                # the smallest piece (which will be p_1) will be current_num // k.
                # This smallest piece becomes the new upper bound (last_val) for nums[i-1].
                last_val = current_num // k

        return replacements
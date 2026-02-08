class Solution:
    def kthSmallestTrimmedNumber(self, nums: list[str], queries: list[list[int]]) -> list[int]:
        ans = []
        n = len(nums)

        for k, trim in queries:
            # Create a list of (trimmed_value, original_index) pairs
            trimmed_numbers_with_indices = []
            for i in range(n):
                num_str = nums[i]

                # Trim the number: take rightmost 'trim' digits, padding with zeros if needed.
                # For example, if num_str = "1" and trim = 3, it should become "001".
                # If num_str = "102" and trim = 2, it should become "02".
                #
                # str.rjust(width, fillchar) pads the string on the left to `width` using `fillchar`.
                # If len(num_str) < trim: rjust will pad with leading zeros to at least length `trim`.
                # If len(num_str) >= trim: rjust will not add padding.
                #
                # Then, [-trim:] takes the rightmost `trim` characters.
                # This combined approach correctly handles both cases:
                # - If the original number is shorter than `trim`, it gets padded and then the full padded string is taken.
                # - If the original number is longer than or equal to `trim`, `rjust` does nothing, and `[-trim:]` correctly extracts the rightmost `trim` digits.
                trimmed_str = num_str.rjust(trim, '0')[-trim:]
                trimmed_value = int(trimmed_str)

                trimmed_numbers_with_indices.append((trimmed_value, i))

            # Sort the list. Python's sort is stable and will use the first element of the tuple
            # (trimmed_value) as the primary key, and the second (original_index) as the
            # secondary key for tie-breaking, which matches the problem's requirement.
            trimmed_numbers_with_indices.sort()

            # The k-th smallest element is at index k-1 (since k is 1-indexed).
            # We need to return its original index.
            ans.append(trimmed_numbers_with_indices[k-1][1])

        return ans
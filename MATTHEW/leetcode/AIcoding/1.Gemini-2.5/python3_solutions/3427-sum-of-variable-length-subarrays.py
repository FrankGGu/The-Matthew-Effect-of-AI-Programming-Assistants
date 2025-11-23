class Solution:
    def sumOddLengthSubarrays(self, arr: list[int]) -> int:
        total_sum = 0
        n = len(arr)

        for i in range(n):
            # Calculate the number of possible starting points for a subarray that includes arr[i]
            # from index 0 up to i. These are l = 0, 1, ..., i.
            # The number of such points is i + 1.
            num_left_elements = i + 1

            # Calculate the number of possible ending points for a subarray that includes arr[i]
            # from index i up to n-1. These are r = i, i+1, ..., n-1.
            # The number of such points is n - i.
            num_right_elements = n - i

            # Calculate how many of the (num_left_elements) segments ending at i have odd length.
            # A segment arr[l...i] has length (i - l + 1).
            # If (i + 1) is odd, then (i+1)/2 segments have odd length and (i+1)/2 segments have even length.
            # If (i + 1) is even, then (i+1)/2 segments have odd length and (i+1)/2 segments have even length.
            # More generally, ceil((i+1)/2) for odd lengths, floor((i+1)/2) for even lengths.
            num_left_odd_len_segments = (num_left_elements + 1) // 2
            num_left_even_len_segments = num_left_elements // 2

            # Do the same for segments starting at i and ending at r.
            # A segment arr[i...r] has length (r - i + 1).
            num_right_odd_len_segments = (num_right_elements + 1) // 2
            num_right_even_len_segments = num_right_elements // 2

            # A subarray arr[l...r] containing arr[i] has length (i - l + 1) + (r - i + 1) - 1.
            # For this length to be odd, the sum of lengths of arr[l...i] and arr[i...r] must be even.
            # This happens if both lengths are odd OR both lengths are even.
            count = (num_left_odd_len_segments * num_right_odd_len_segments) + \
                    (num_left_even_len_segments * num_right_even_len_segments)

            total_sum += arr[i] * count

        return total_sum
class Solution:
    def findKthBit(self, n: int, k: int) -> str:
        flip_count = 0
        while n > 1:
            # mid represents the length of the string S_{n-1}
            # The full string S_n has length 2**(n-1)
            # The first half (S_{n-1}) has length 2**(n-2)
            # The second half (inverted S_{n-1}) also has length 2**(n-2)
            mid = 2**(n - 2)

            if k <= mid:
                # If k is in the first half, the character is the same as in S_{n-1}
                n -= 1
            else:
                # If k is in the second half, the character is the inverted version
                # of the corresponding character in S_{n-1}.
                # The k-th character in S_n's second half corresponds to the (k - mid)-th
                # character of the inverted S_{n-1}.
                k -= mid
                flip_count += 1
                n -= 1

        # After the loop, n becomes 1, and k becomes 1.
        # The base string S_1 is "0".
        # If flip_count is even, the final character is '0' (original state).
        # If flip_count is odd, the final character is '1' (inverted state).
        if flip_count % 2 == 0:
            return '0'
        else:
            return '1'
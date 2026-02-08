class Solution:
    def kthPalindrome(self, queries: list[int], intLength: int) -> list[int]:
        results = []

        # Calculate the length of the first half of the palindrome.
        # For intLength = 5 (e.g., 12321), the 'root' or first half that determines it is "123". Length is (5+1)//2 = 3.
        # For intLength = 4 (e.g., 1221), the 'root' or first half that determines it is "12". Length is (4+1)//2 = 2.
        half_len = (intLength + 1) // 2

        # The smallest number with `half_len` digits.
        # This forms the smallest 'root' for a palindrome of intLength.
        # E.g., for half_len=3, smallest is 100.
        start_num = 10**(half_len - 1)

        # The largest number with `half_len` digits.
        # This forms the largest 'root' for a palindrome of intLength.
        # E.g., for half_len=3, largest is 999.
        end_num = 10**half_len - 1

        for q in queries:
            # The q-th palindrome is constructed from the (start_num + q - 1)-th number
            # in the sequence of `half_len`-digit numbers.
            current_num_base = start_num + q - 1

            if current_num_base > end_num:
                # If current_num_base exceeds the range of possible 'roots',
                # it means there are not enough palindromes of intLength.
                results.append(-1)
            else:
                s_num = str(current_num_base)

                # Construct the second half of the palindrome.
                # If intLength is odd (e.g., 5, s_num="123"), the palindrome is "123" + "21".
                # The "21" part is the reverse of "12" (s_num without its last digit).
                # This corresponds to s_num[::-1][1:].
                # If intLength is even (e.g., 4, s_num="12"), the palindrome is "12" + "21".
                # The "21" part is the reverse of "12" (s_num itself).
                # This corresponds to s_num[::-1][0:].
                # The slice index `intLength % 2` handles both cases:
                # 1 for odd intLength, 0 for even intLength.
                second_half_suffix = s_num[::-1][(intLength % 2):]

                palindrome_str = s_num + second_half_suffix
                results.append(int(palindrome_str))

        return results
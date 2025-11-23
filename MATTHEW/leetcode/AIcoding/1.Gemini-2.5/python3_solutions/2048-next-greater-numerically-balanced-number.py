import itertools

class Solution:
    def nextGreaterNumericallyBalanced(self, n: int) -> int:
        balanced_numbers = set()

        def generate_multisets(digit_idx, current_multiset, current_length):
            # Base case: finished considering all digits from 1 to 9
            if digit_idx > 9:
                # If no digits were chosen, it's not a valid number
                if current_length == 0:
                    return

                # Generate all unique permutations of the current multiset
                # and add them to the set of balanced numbers
                # The set handles duplicate numbers (e.g., 122, 212, 221 all result in 122 if sorted)
                # However, we need to generate all distinct numerical values,
                # so we generate permutations and convert to int.
                for p in itertools.permutations(current_multiset):
                    # Convert tuple of digits to an integer
                    # A number cannot start with 0, but our digits are 1-9, so this is not an issue.
                    num_str = "".join(map(str, p))
                    balanced_numbers.add(int(num_str))
                return

            # Option 1: Do not include digit_idx in the multiset
            generate_multisets(digit_idx + 1, current_multiset, current_length)

            # Option 2: Include digit_idx in the multiset
            # Check if including digit_idx would exceed the maximum required length.
            # Given n <= 10^6, the next greater balanced number will not exceed 10 digits.
            # (e.g., if n=999999, the answer is 1223334444 which is 10 digits).
            # The sum of digits in the multiset equals the length of the number.
            new_length = current_length + digit_idx
            if new_length <= 10: # Pruning: limit to numbers with at most 10 digits
                new_multiset = current_multiset + [digit_idx] * digit_idx
                generate_multisets(digit_idx + 1, new_multiset, new_length)

        # Start generation from digit 1 with an empty multiset and length 0
        generate_multisets(1, [], 0)

        # Convert the set of balanced numbers to a sorted list
        sorted_balanced_numbers = sorted(list(balanced_numbers))

        # Find the smallest balanced number strictly greater than n
        for num in sorted_balanced_numbers:
            if num > n:
                return num

        # This line should theoretically not be reached given the problem constraints
        # (n <= 10^6, and there are balanced numbers up to 10 digits).
        return -1
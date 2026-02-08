import collections

class Solution:
    def smallestDivisibleDigitProductII(self, N: int) -> str:
        # This problem description is missing, so the solution is based on a common interpretation.
        # Assumption: Find the smallest positive integer X such that:
        # 1. X is divisible by N.
        # 2. The product of its digits (which must be non-zero) is also divisible by N.
        # 3. X is formed using digits from 1 to 9.
        # 4. If no such X exists, return "-1".

        if N == 1:
            return "1"

        # If N is a multiple of 10, then X must end in 0 to be divisible by N.
        # However, the problem assumes digits are from 1 to 9 (non-zero).
        # Therefore, if N is a multiple of 10, no solution exists under this constraint.
        if N % 10 == 0:
            return "-1"

        # BFS state: (current_remainder_mod_N, current_product_mod_N, current_number_string)
        # We start with an "empty" number, which has a remainder of 0 and a product of 1
        # (multiplicative identity) before any digits are added.
        queue = collections.deque([(0, 1, "")])

        # visited set to store (remainder_mod_N, product_mod_N) to avoid redundant computations
        # and cycles. This ensures we find the smallest number (shortest path in BFS).
        # The initial state (0, 1) represents the state before any digits are appended.
        visited = set([(0, 1)])

        while queue:
            rem, prod_mod_N, num_str = queue.popleft()

            for digit in range(1, 10):
                new_rem = (rem * 10 + digit) % N
                new_prod_mod_N = (prod_mod_N * digit) % N
                new_num_str = num_str + str(digit)

                # If this state (new_rem, new_prod_mod_N) has been visited, skip.
                if (new_rem, new_prod_mod_N) in visited:
                    continue

                visited.add((new_rem, new_prod_mod_N))

                # Check if both conditions are met:
                # 1. new_rem == 0 (X is divisible by N)
                # 2. new_prod_mod_N == 0 (product of digits of X is divisible by N)
                if new_rem == 0 and new_prod_mod_N == 0:
                    return new_num_str

                # Add to queue for further exploration
                queue.append((new_rem, new_prod_mod_N, new_num_str))

        # If the queue becomes empty and no solution is found after exploring all reachable states
        return "-1"
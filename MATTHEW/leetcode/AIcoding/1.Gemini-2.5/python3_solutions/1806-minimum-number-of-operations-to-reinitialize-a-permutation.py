class Solution:
    def reinitializePermutation(self, n: int) -> int:
        if n == 2:
            return 1

        # The permutation can be viewed as tracking the index of an element.
        # An element initially at index `i` moves to a new index `g(i)`.
        # g(i) = 2 * i if i < n / 2
        # g(i) = 2 * i - n + 1 if i >= n / 2
        # This mapping is equivalent to g(i) = (2 * i) % (n - 1) for i in [1, ..., n-2].
        # Elements 0 and n-1 are fixed points.
        # We need to find the smallest k > 0 such that g^k(i) = i for all i.
        # This is equivalent to finding the order of 2 modulo (n-1) for the element 1.

        current_pos_of_one = 1
        operations = 0

        while True:
            operations += 1
            current_pos_of_one = (current_pos_of_one * 2) % (n - 1)
            if current_pos_of_one == 1:
                return operations
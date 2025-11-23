import math

class TreeAncestor:

    def __init__(self, n: int, parent: List[int]):
        # MAX_LOG determines the maximum power of 2 we precompute for ancestors.
        # For n up to 5*10^4, log2(5*10^4) is about 15.6.
        # We need to precompute up to 2^15, which corresponds to index 15.
        # n.bit_length() gives the number of bits required to represent n.
        # For n=1, bit_length=1. For n=7, bit_length=3. For n=50000, bit_length=16.
        # This means we need indices from 0 up to (bit_length - 1).
        self.MAX_LOG = n.bit_length()

        # up[node][j] stores the 2^j-th ancestor of 'node'.
        # Initialize all entries to -1, indicating no ancestor or beyond the root.
        self.up = [[-1] * self.MAX_LOG for _ in range(n)]

        # The 2^0-th ancestor (1st ancestor) of a node is its direct parent.
        for i in range(n):
            self.up[i][0] = parent[i]

        # Precompute 2^j-th ancestors for j > 0 using dynamic programming.
        # up[node][j] = up[up[node][j-1]][j-1]
        # This means the 2^j-th ancestor of 'node' is the 2^(j-1)-th ancestor
        # of the 2^(j-1)-th ancestor of 'node'.
        for j in range(1, self.MAX_LOG):
            for i in range(n):
                # If the 2^(j-1)-th ancestor of 'i' exists (is not -1)
                if self.up[i][j-1] != -1:
                    # Then its 2^(j-1)-th ancestor is the 2^j-th ancestor of 'i'.
                    self.up[i][j] = self.up[self.up[i][j-1]][j-1]

    def getKthAncestor(self, node: int, k: int) -> int:
        # To find the k-th ancestor, we decompose k into powers of 2.
        # We iterate from the largest power of 2 down to 2^0.
        for j in range(self.MAX_LOG - 1, -1, -1):
            # Check if the j-th bit of k is set (i.e., if k includes a jump of 2^j).
            if (k >> j) & 1:
                # If it is, move 'node' to its 2^j-th ancestor.
                node = self.up[node][j]
                # If 'node' becomes -1, it means we've gone past the root
                # and the k-th ancestor does not exist.
                if node == -1:
                    return -1
        # After iterating through all bits of k, 'node' will be the k-th ancestor.
        return node
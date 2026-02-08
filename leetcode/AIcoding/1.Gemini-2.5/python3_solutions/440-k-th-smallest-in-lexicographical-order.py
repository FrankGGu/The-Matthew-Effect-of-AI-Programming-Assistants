class Solution:
    def findKthNumber(self, n: int, k: int) -> int:
        current = 1
        k -= 1  # Adjust k to be 0-indexed. We are looking for the k-th element after 'current'.

        while k > 0:
            # Calculate the count of numbers in the subtree rooted at 'current'.
            # These are numbers starting with 'current' or its descendants.
            count = 0
            node = current
            next_node = current + 1
            while node <= n:
                count += min(n + 1, next_node) - node
                node *= 10
                next_node *= 10

            if k >= count:
                # The k-th number is not in the subtree rooted at 'current'.
                # Skip this entire subtree and move to the next sibling.
                k -= count
                current += 1
            else:
                # The k-th number is in the subtree rooted at 'current'.
                # Go deeper into the children of 'current'.
                # We consume 'current' itself (which is the first element in its subtree).
                k -= 1 
                current *= 10

        return current
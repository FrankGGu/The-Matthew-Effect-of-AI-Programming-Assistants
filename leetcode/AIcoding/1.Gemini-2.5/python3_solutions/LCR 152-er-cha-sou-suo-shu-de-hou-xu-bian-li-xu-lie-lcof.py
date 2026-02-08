class Solution:
    def verifyPostorder(self, postorder: list[int]) -> bool:
        def verify(start, end):
            # Base case: an empty or single-node subtree is always a valid BST postorder
            if start >= end:
                return True

            # The last element in the postorder sequence of a subtree is its root
            root_val = postorder[end]

            # Find the split point for left and right subtrees
            # 'i' will be the first index where elements are greater than root_val
            # All elements from postorder[start] to postorder[i-1] belong to the left subtree
            # and must be less than root_val.
            i = start
            while i < end and postorder[i] < root_val:
                i += 1

            # All elements from postorder[i] to postorder[end-1] belong to the right subtree
            # and must be greater than root_val.
            # We iterate through this segment to ensure this property holds.
            j = i
            while j < end and postorder[j] > root_val:
                j += 1

            # If 'j' has not reached 'end', it means we found an element postorder[j]
            # in the right subtree segment that was not greater than root_val (i.e., postorder[j] <= root_val).
            # This violates the BST property, so the sequence is invalid.
            if j != end:
                return False

            # Recursively verify the left and right subtrees
            # Left subtree: elements from 'start' to 'i-1'
            # Right subtree: elements from 'i' to 'end-1'
            return verify(start, i - 1) and verify(i, end - 1)

        # Initiate the verification process for the entire postorder sequence
        return verify(0, len(postorder) - 1)
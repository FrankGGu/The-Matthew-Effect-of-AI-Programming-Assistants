class Solution:
    def subtreeInversionSum(self, root: Optional[TreeNode]) -> int:
        self.total_sum = 0

        # Helper function to count inversions in a list using a modified merge sort.
        # It returns a tuple: (inversion_count, sorted_list_of_elements).
        # The sorted_list_of_elements is used internally for merging, but not returned by DFS.
        def merge_sort_and_count_inversions(arr):
            if len(arr) <= 1:
                return 0, arr

            mid = len(arr) // 2
            left_count, left_sorted = merge_sort_and_count_inversions(arr[:mid])
            right_count, right_sorted = merge_sort_and_count_inversions(arr[mid:])

            current_inv = left_count + right_count
            merged = []
            i, j = 0, 0
            while i < len(left_sorted) and j < len(right_sorted):
                if left_sorted[i] <= right_sorted[j]:
                    merged.append(left_sorted[i])
                    i += 1
                else:
                    merged.append(right_sorted[j])
                    # If an element from the right half is smaller than an element
                    # from the left half, then all remaining elements in the left half
                    # (from index i onwards) also form inversions with the current right element.
                    current_inv += (len(left_sorted) - i)
                    j += 1

            # Add any remaining elements
            merged.extend(left_sorted[i:])
            merged.extend(right_sorted[j:])

            return current_inv, merged

        # DFS function to traverse the tree.
        # For each node, it collects the in-order traversal values of its subtree,
        # calculates the inversions in that sequence, adds to total_sum,
        # and returns the in-order sequence to its parent.
        def dfs(node):
            if not node:
                return []

            left_values = dfs(node.left)
            right_values = dfs(node.right)

            # Construct the in-order list of values for the current subtree
            current_subtree_in_order_list = left_values + [node.val] + right_values

            # Calculate inversions for this specific in-order list
            inversions_for_this_subtree, _ = merge_sort_and_count_inversions(current_subtree_in_order_list)

            # Accumulate the inversion sum for this subtree to the global total
            self.total_sum += inversions_for_this_subtree

            # Return the in-order list (which is not sorted) for the parent node
            return current_subtree_in_order_list

        dfs(root)
        return self.total_sum
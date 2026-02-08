from typing import Optional

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def removeZeroSumSublists(self, head: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0)
        dummy.next = head

        # Map to store the last node where a particular prefix sum was encountered.
        # Key: prefix sum, Value: ListNode (the node *at* which the sum was achieved)
        prefix_sums = {0: dummy}

        current_prefix_sum = 0
        walker = dummy

        # Iterate through the linked list, starting from the dummy node
        while walker:
            current_prefix_sum += walker.val

            if current_prefix_sum in prefix_sums:
                # If the current_prefix_sum has been seen before, it means the sublist
                # between the previous occurrence of this sum and the current node sums to zero.

                # 'prev_node_with_same_sum' is the node where 'current_prefix_sum' was last seen.
                # The segment from 'prev_node_with_same_sum.next' to 'walker' sums to zero.
                prev_node_with_same_sum = prefix_sums[current_prefix_sum]

                # Remove entries from map for nodes within the zero-sum segment.
                # Iterate from 'prev_node_with_same_sum.next' up to 'walker' (inclusive).
                # The prefix sums for these nodes are no longer valid.

                # Start from the node *after* prev_node_with_same_sum
                temp_node = prev_node_with_same_sum.next

                # The sum *at* prev_node_with_same_sum is `current_prefix_sum`.
                # We need to calculate sums for nodes from `temp_node` onwards.
                temp_sum_tracker = current_prefix_sum # Start with sum at prev_node_with_same_sum

                # Iterate through all nodes from prev_node_with_same_sum.next to walker (inclusive)
                while temp_node != walker.next: 
                    temp_sum_tracker += temp_node.val
                    # Only delete if this sum was actually recorded in the map
                    # and it points to a node within the segment being removed.
                    # The entry for `current_prefix_sum` pointing to `prev_node_with_same_sum`
                    # should NOT be deleted, as it's the anchor.
                    if temp_sum_tracker in prefix_sums:
                        del prefix_sums[temp_sum_tracker]
                    temp_node = temp_node.next

                # After clearing relevant entries from the map, link prev_node_with_same_sum to walker.next
                prev_node_with_same_sum.next = walker.next

                # Reset 'walker' to 'prev_node_with_same_sum'.
                # In the next iteration of the main loop, 'walker' will move to 'prev_node_with_same_sum.next'
                # (which is now 'walker.next'). This ensures proper continuation.
                # The 'current_prefix_sum' variable already holds the sum up to 'prev_node_with_same_sum'.
                walker = prev_node_with_same_sum

            else:
                # Store the current node as the last occurrence of 'current_prefix_sum'.
                prefix_sums[current_prefix_sum] = walker

            # Move to the next node in the list
            walker = walker.next

        return dummy.next
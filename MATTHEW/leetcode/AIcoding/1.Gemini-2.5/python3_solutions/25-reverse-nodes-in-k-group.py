class Solution:
    def reverseKGroup(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        if not head or k == 1:
            return head

        # Check if there are at least k nodes remaining
        curr = head
        count = 0
        while curr and count < k:
            curr = curr.next
            count += 1

        # If not enough nodes to form a k-group, return the head as is
        if count < k:
            return head

        # Reverse the first k nodes
        prev = None
        curr_reverse = head 
        for _ in range(k):
            next_node = curr_reverse.next
            curr_reverse.next = prev
            prev = curr_reverse
            curr_reverse = next_node

        # After reversing:
        # 'prev' is the new head of the reversed segment (e.g., node 2 for 1->2)
        # 'head' (the original head) is now the tail of the reversed segment (e.g., node 1 for 1->2)
        # 'curr_reverse' is the head of the next segment to be processed (e.g., node 3 for 1->2->3->4->5, k=2)

        # Connect the old head (which is now the tail of the reversed segment)
        # to the recursively reversed rest of the list
        head.next = self.reverseKGroup(curr_reverse, k)

        # Return the new head of this segment
        return prev
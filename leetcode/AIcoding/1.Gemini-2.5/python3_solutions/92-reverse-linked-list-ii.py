class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseBetween(self, head: ListNode, left: int, right: int) -> ListNode:
        if not head or left == right:
            return head

        dummy = ListNode(0)
        dummy.next = head

        # Find the node just before the 'left'-th node
        prev = dummy
        for _ in range(left - 1):
            prev = prev.next

        # 'start' is the 'left'-th node, which will be the tail of the reversed sublist
        # 'curr' is used for iterating and reversing
        start = prev.next
        curr = start

        # 'prev_node_in_sublist_reverse' will be the head of the reversed sublist
        prev_node_in_sublist_reverse = None

        # Reverse the sublist from 'left' to 'right'
        for _ in range(right - left + 1):
            next_node = curr.next
            curr.next = prev_node_in_sublist_reverse
            prev_node_in_sublist_reverse = curr
            curr = next_node

        # Connect the parts
        # 1. The node before 'left' should point to the new head of the reversed sublist
        prev.next = prev_node_in_sublist_reverse
        # 2. The original 'left'-th node (now the tail of the reversed sublist)
        #    should point to the node after the original 'right'-th node
        start.next = curr

        return dummy.next
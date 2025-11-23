class Solution:
    def mergeInBetween(self, list1: ListNode, a: int, b: int, list2: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = list1

        prev_a_node = dummy
        for _ in range(a):
            prev_a_node = prev_a_node.next

        node_b = dummy
        for _ in range(b + 1):
            node_b = node_b.next

        next_b_node = node_b.next

        prev_a_node.next = list2

        curr_list2_tail = list2
        while curr_list2_tail.next:
            curr_list2_tail = curr_list2_tail.next

        curr_list2_tail.next = next_b_node

        return dummy.next
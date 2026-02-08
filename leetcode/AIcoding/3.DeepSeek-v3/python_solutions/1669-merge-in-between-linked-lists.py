class Solution:
    def mergeInBetween(self, list1: ListNode, a: int, b: int, list2: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = list1
        prev_a = dummy
        for _ in range(a):
            prev_a = prev_a.next

        node_b = prev_a.next
        for _ in range(b - a + 1):
            node_b = node_b.next

        prev_a.next = list2

        tail_list2 = list2
        while tail_list2.next:
            tail_list2 = tail_list2.next

        tail_list2.next = node_b

        return dummy.next
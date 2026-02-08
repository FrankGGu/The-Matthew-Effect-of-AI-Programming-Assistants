class Solution:
    def trainingPlan(self, head: ListNode, l: int, r: int) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        pre_l = dummy
        for _ in range(l):
            pre_l = pre_l.next
        l_node = pre_l.next

        pre_r = dummy
        for _ in range(r):
            pre_r = pre_r.next
        r_node = pre_r.next

        post_r = r_node.next
        post_l = l_node.next

        pre_l.next = r_node
        r_node.next = post_l
        pre_r.next = l_node
        l_node.next = post_r

        return dummy.next
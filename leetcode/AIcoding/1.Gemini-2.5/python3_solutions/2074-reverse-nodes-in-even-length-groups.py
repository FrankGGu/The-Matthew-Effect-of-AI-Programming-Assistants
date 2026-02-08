class Solution:
    def reverseEvenLengthGroups(self, head: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0, head)
        prev_group_tail = dummy
        group_len = 1
        curr = head

        while curr:
            group_head = curr
            temp_curr = curr
            actual_group_len = 0

            for _ in range(group_len):
                if temp_curr:
                    actual_group_len += 1
                    group_end = temp_curr
                    temp_curr = temp_curr.next
                else:
                    break

            next_group_start = temp_curr

            if actual_group_len % 2 == 0:
                prev_node_for_reverse = None
                curr_node_for_reverse = group_head

                for _ in range(actual_group_len):
                    temp_next = curr_node_for_reverse.next
                    curr_node_for_reverse.next = prev_node_for_reverse
                    prev_node_for_reverse = curr_node_for_reverse
                    curr_node_for_reverse = temp_next

                prev_group_tail.next = group_end
                group_head.next = next_group_start
                prev_group_tail = group_head
            else:
                prev_group_tail = group_end

            curr = next_group_start
            group_len += 1

        return dummy.next
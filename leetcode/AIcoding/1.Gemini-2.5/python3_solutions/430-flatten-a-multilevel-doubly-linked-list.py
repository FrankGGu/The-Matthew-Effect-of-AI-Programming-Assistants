class Solution:
    def flatten(self, head: 'Node') -> 'Node':
        if not head:
            return head

        curr = head
        while curr:
            if curr.child:
                next_node = curr.next

                curr.next = curr.child
                curr.child.prev = curr

                p = curr.child
                while p.next:
                    if p.child:
                        sub_child_head = p.child
                        sub_child_next = p.next

                        p.next = sub_child_head
                        sub_child_head.prev = p

                        temp_sub_child_tail = sub_child_head
                        while temp_sub_child_tail.next:
                            temp_sub_child_tail = temp_sub_child_tail.next

                        temp_sub_child_tail.next = sub_child_next
                        if sub_child_next:
                            sub_child_next.prev = temp_sub_child_tail

                        p.child = None
                        p = temp_sub_child_tail
                    else:
                        p = p.next

                child_tail = p

                if next_node:
                    child_tail.next = next_node
                    next_node.prev = child_tail

                curr.child = None

            curr = curr.next

        return head
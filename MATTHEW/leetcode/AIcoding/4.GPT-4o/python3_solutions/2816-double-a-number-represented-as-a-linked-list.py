class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def doubleIt(head: ListNode) -> ListNode:
    def reverse(head):
        prev = None
        while head:
            next_node = head.next
            head.next = prev
            prev = head
            head = next_node
        return prev

    head = reverse(head)
    carry = 0
    current = head

    while current:
        current.val = current.val * 2 + carry
        carry = current.val // 10
        current.val %= 10
        current = current.next

    if carry:
        new_head = ListNode(carry)
        new_head.next = head
        return new_head
    return head
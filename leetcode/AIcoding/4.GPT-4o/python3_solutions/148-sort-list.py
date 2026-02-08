class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def sortList(head: ListNode) -> ListNode:
    if not head or not head.next:
        return head

    def split(head):
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
        mid = slow
        prev = head
        while prev.next != mid:
            prev = prev.next
        prev.next = None
        return head, mid

    def merge(left, right):
        dummy = ListNode()
        tail = dummy
        while left and right:
            if left.val < right.val:
                tail.next = left
                left = left.next
            else:
                tail.next = right
                right = right.next
            tail = tail.next
        tail.next = left or right
        return dummy.next

    left, right = split(head)
    return merge(sortList(left), sortList(right))
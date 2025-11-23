class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def mergeInBetween(list1: ListNode, a: int, b: int, list2: ListNode) -> ListNode:
    dummy = ListNode(0)
    dummy.next = list1
    prev = dummy

    for _ in range(a):
        prev = prev.next

    curr = prev.next
    for _ in range(b - a + 1):
        curr = curr.next

    prev.next = list2

    while list2.next:
        list2 = list2.next

    list2.next = curr

    return dummy.next
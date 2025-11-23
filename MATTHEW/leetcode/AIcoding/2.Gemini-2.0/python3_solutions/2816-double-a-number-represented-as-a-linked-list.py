class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def doubleIt(self, head: ListNode) -> ListNode:
        num_str = ""
        curr = head
        while curr:
            num_str += str(curr.val)
            curr = curr.next

        num = int(num_str) * 2
        num_str = str(num)

        new_head = ListNode(int(num_str[0]))
        curr = new_head
        for i in range(1, len(num_str)):
            curr.next = ListNode(int(num_str[i]))
            curr = curr.next

        return new_head
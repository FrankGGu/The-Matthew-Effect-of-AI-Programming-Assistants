class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def removeNodes(self, head: ListNode) -> ListNode:
        stack = []
        curr = head
        while curr:
            while stack and stack[-1].val < curr.val:
                stack.pop()
            if stack:
                curr.next = curr.next
            else:
                curr.next = curr.next
            stack.append(curr)
            curr = curr.next

        return stack[0] if stack else None
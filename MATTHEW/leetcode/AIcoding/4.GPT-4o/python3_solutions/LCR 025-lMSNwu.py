class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def addTwoNumbers(self, l1: ListNode, l2: ListNode) -> ListNode:
        def stackify(node):
            stack = []
            while node:
                stack.append(node.val)
                node = node.next
            return stack

        stack1 = stackify(l1)
        stack2 = stackify(l2)

        carry = 0
        head = None

        while stack1 or stack2 or carry:
            val1 = stack1.pop() if stack1 else 0
            val2 = stack2.pop() if stack2 else 0

            total = val1 + val2 + carry
            carry = total // 10
            node = ListNode(total % 10)
            node.next = head
            head = node

        return head
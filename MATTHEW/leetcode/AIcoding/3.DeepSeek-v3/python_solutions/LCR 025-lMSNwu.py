class Solution:
    def addTwoNumbers(self, l1: ListNode, l2: ListNode) -> ListNode:
        stack1 = []
        stack2 = []

        while l1:
            stack1.append(l1.val)
            l1 = l1.next
        while l2:
            stack2.append(l2.val)
            l2 = l2.next

        carry = 0
        head = None

        while stack1 or stack2 or carry:
            sum_val = carry
            if stack1:
                sum_val += stack1.pop()
            if stack2:
                sum_val += stack2.pop()

            carry = sum_val // 10
            new_node = ListNode(sum_val % 10)
            new_node.next = head
            head = new_node

        return head
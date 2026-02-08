class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def nextLargerNodes(self, head: ListNode) -> List[int]:
        stack = []
        result = []
        idx = 0

        while head:
            result.append(0)
            while stack and head.val > stack[-1][1]:
                result[stack.pop()[0]] = head.val
            stack.append((idx, head.val))
            head = head.next
            idx += 1

        return result
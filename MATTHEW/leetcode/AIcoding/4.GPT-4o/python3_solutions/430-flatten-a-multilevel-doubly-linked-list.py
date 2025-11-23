class Node:
    def __init__(self, val=0, prev=None, next=None, child=None):
        self.val = val
        self.prev = prev
        self.next = next
        self.child = child

class Solution:
    def flatten(self, head: 'Node') -> 'Node':
        if not head:
            return None

        stack = []
        current = head
        prev = None

        while current or stack:
            if current:
                if prev:
                    prev.next = current
                    current.prev = prev
                stack.append(current)
                prev = current
                current = current.child
            else:
                current = stack.pop()
                current.child = None

        return head
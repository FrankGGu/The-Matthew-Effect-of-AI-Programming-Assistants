class Node:
    def __init__(self, val=None, prev=None, next=None, child=None):
        self.val = val
        self.prev = prev
        self.next = next
        self.child = child

class Solution:
    def flatten(self, head: 'Node') -> 'Node':
        if not head:
            return head

        stack = []
        current = head

        while current or stack:
            if current:
                if current.child:
                    if current.next:
                        stack.append(current.next)
                    current.next = current.child
                    current.child.prev = current
                    current.child = None
                current = current.next
            else:
                current = stack.pop()

        return head
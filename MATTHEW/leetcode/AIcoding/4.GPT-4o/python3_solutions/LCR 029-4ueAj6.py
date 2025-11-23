class Node:
    def __init__(self, val):
        self.val = val
        self.next = None

class Solution:
    def insert(self, head: Node, insertVal: int) -> Node:
        newNode = Node(insertVal)
        if not head:
            newNode.next = newNode
            return newNode

        prev, curr = head, head.next
        while True:
            if prev.val <= insertVal <= curr.val:
                break
            if prev.val > curr.val:
                if insertVal >= prev.val or insertVal <= curr.val:
                    break
            prev, curr = curr, curr.next
            if prev == head:
                break

        prev.next = newNode
        newNode.next = curr
        return head
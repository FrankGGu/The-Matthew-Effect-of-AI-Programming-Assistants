import random

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:

    def __init__(self, head: ListNode):
        self.head = head
        self.nodes = []
        while head:
            self.nodes.append(head.val)
            head = head.next

    def getRandom(self) -> int:
        return random.choice(self.nodes)
import random

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:

    def __init__(self, head: Optional[ListNode]):
        self.nodes = []
        current = head
        while current:
            self.nodes.append(current.val)
            current = current.next

    def getRandom(self) -> int:
        return random.choice(self.nodes)
import random

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:

    def __init__(self, head: ListNode):
        self.head = head

    def getRandom(self) -> int:
        scope = 1
        chosen_value = self.head.val
        current = self.head.next

        while current:
            if random.random() < 1 / scope:
                chosen_value = current.val
            scope += 1
            current = current.next

        return chosen_value
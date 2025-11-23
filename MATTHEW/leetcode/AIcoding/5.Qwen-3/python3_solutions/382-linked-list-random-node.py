import random

class Solution:
    def __init__(self, head: ListNode):
        self.head = head

    def getRandom(self) -> int:
        result = 0
        current = self.head
        count = 0
        while current:
            if random.randint(0, count) == 0:
                result = current.val
            current = current.next
            count += 1
        return result
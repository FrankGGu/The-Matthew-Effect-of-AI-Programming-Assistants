import random

class Solution:

    def __init__(self, head: Optional[ListNode]):
        self.head = head

    def getRandom(self) -> int:
        scope = 1
        chosen_value = 0
        current = self.head

        while current:
            if random.random() < 1 / scope:
                chosen_value = current.val
            current = current.next
            scope += 1
        return chosen_value
class Solution:
    def getDecimalValue(self, head: ListNode) -> int:
        result = 0
        current = head
        while current:
            result = result * 2 + current.val
            current = current.next
        return result
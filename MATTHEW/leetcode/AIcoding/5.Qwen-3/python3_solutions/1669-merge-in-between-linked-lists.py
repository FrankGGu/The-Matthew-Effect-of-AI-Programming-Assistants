class Solution:
    def mergeInBetween(self, list1: ListNode, startIdx: int, endIdx: int, list2: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = list1
        prev = dummy
        curr = list1
        i = 0
        while i < startIdx:
            prev = curr
            curr = curr.next
            i += 1
        while i <= endIdx:
            curr = curr.next
            i += 1
        prev.next = list2
        while list2.next:
            list2 = list2.next
        list2.next = curr
        return dummy.next
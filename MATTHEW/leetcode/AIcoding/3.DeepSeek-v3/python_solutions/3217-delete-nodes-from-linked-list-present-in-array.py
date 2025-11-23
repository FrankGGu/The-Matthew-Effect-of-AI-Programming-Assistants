class Solution:
    def deleteNodes(self, head: ListNode, nums: List[int]) -> ListNode:
        nums_set = set(nums)
        dummy = ListNode(0)
        dummy.next = head
        prev = dummy
        current = head

        while current:
            if current.val in nums_set:
                prev.next = current.next
            else:
                prev = current
            current = current.next

        return dummy.next
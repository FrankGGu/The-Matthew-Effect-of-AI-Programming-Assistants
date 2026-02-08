class Solution:
    def deleteNodes(self, head: Optional[ListNode], nums: List[int]) -> Optional[ListNode]:
        nums_set = set(nums)

        dummy = ListNode(0)
        dummy.next = head

        prev = dummy
        curr = head

        while curr:
            if curr.val in nums_set:
                prev.next = curr.next
            else:
                prev = curr

            curr = curr.next

        return dummy.next
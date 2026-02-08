class Solution:
    def reverseBookList(self, head: Optional[ListNode]) -> List[int]:
        res = []
        while head:
            res.append(head.val)
            head = head.next
        return res[::-1]
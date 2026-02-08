class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def numComponents(self, head: ListNode, nums: list[int]) -> int:
        s = set(nums)
        res = 0
        while head:
            if head.val in s and (head.next is None or head.next.val not in s):
                res += 1
            head = head.next
        return res
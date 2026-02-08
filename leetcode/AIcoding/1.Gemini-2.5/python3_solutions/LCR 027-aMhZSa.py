class Solution:
    def isPalindrome(self, head: Optional[ListNode]) -> bool:
        if not head or not head.next:
            return True

        # Find the middle of the linked list
        slow = head
        fast = head
        while fast.next and fast.next.next:
            slow = slow.next
            fast = fast.next.next

        # Reverse the second half of the linked list
        # The second half starts from slow.next
        second_half_start = slow.next
        slow.next = None # Break the link between the first and second half

        prev = None
        curr = second_half_start
        while curr:
            next_temp = curr.next
            curr.next = prev
            prev = curr
            curr = next_temp

        reversed_second_half_head = prev

        # Compare the first half with the reversed second half
        p1 = head
        p2 = reversed_second_half_head
        while p1 and p2:
            if p1.val != p2.val:
                return False
            p1 = p1.next
            p2 = p2.next

        return True
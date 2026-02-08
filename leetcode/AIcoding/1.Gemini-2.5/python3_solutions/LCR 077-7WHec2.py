class Solution:
    def sortList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if not head or not head.next:
            return head

        # Step 1: Divide the list into two halves
        # Use slow and fast pointers to find the middle
        slow = head
        fast = head
        prev = None # To keep track of the node before slow, to break the list

        while fast and fast.next:
            prev = slow
            slow = slow.next
            fast = fast.next.next

        # 'slow' is now the head of the second half
        # 'prev' is the last node of the first half

        # Break the link to separate the two halves
        if prev:
            prev.next = None

        # Step 2: Recursively sort each half
        left_half = self.sortList(head)
        right_half = self.sortList(slow) # 'slow' is the head of the second part

        # Step 3: Merge the two sorted halves
        return self.mergeTwoLists(left_half, right_half)

    def mergeTwoLists(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0)
        current = dummy

        while l1 and l2:
            if l1.val < l2.val:
                current.next = l1
                l1 = l1.next
            else:
                current.next = l2
                l2 = l2.next
            current = current.next

        # Attach the remaining part of either list
        if l1:
            current.next = l1
        elif l2:
            current.next = l2

        return dummy.next
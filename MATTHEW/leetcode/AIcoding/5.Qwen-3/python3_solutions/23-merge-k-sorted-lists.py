class Solution:
    def mergeKLists(self, lists: List[ListNode]) -> ListNode:
        import heapq
        heap = []
        for l in lists:
            if l:
                heapq.heappush(heap, (l.val, l))
        dummy = ListNode(0)
        current = dummy
        while heap:
            val, node = heapq.heappop(heap)
            current.next = node
            current = current.next
            if node.next:
                heapq.heappush(heap, (node.val, node.next))
        return dummy.next
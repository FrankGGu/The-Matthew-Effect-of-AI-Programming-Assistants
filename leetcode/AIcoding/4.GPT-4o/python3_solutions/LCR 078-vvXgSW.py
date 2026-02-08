from typing import List, Optional
import heapq

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        min_heap = []

        for i, l in enumerate(lists):
            if l:
                heapq.heappush(min_heap, (l.val, i, l))

        head = point = ListNode(0)

        while min_heap:
            val, idx, node = heapq.heappop(min_heap)
            point.next = node
            point = point.next
            if node.next:
                heapq.heappush(min_heap, (node.next.val, idx, node.next))

        return head.next
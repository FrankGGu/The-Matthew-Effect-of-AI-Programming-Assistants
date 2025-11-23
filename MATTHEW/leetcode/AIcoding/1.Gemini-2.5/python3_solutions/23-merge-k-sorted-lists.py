import heapq
from typing import List, Optional

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        min_heap = []

        dummy = ListNode(0)
        current = dummy

        # Counter for unique tie-breaking in the heap.
        # This is necessary because ListNode objects are not directly comparable by default,
        # and heapq needs to compare elements if the primary (val) and secondary (counter) keys are equal.
        # By ensuring the counter is unique for each node pushed, we avoid direct ListNode comparison.
        counter = 0 

        # Initialize the heap with the head of each list
        for node_list in lists:
            if node_list:
                heapq.heappush(min_heap, (node_list.val, counter, node_list))
                counter += 1

        while min_heap:
            val, _, node = heapq.heappop(min_heap)

            current.next = node
            current = current.next

            if node.next:
                heapq.heappush(min_heap, (node.next.val, counter, node.next))
                counter += 1

        return dummy.next
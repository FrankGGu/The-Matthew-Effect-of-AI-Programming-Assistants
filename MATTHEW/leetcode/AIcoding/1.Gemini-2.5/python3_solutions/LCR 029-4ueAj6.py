class Node:
    def __init__(self, val=None, next=None):
        self.val = val
        self.next = next

class Solution:
    def insert(self, head: 'Node', insertVal: int) -> 'Node':
        new_node = Node(insertVal)

        if not head:
            new_node.next = new_node
            return new_node

        prev = head
        curr = head.next
        inserted = False

        while True:
            # Case 1: Insert in the middle of an ascending sequence
            # e.g., ...3 -> 4 -> 5... and insertVal is 4.5
            if prev.val <= insertVal <= curr.val:
                prev.next = new_node
                new_node.next = curr
                inserted = True
                break
            # Case 2: Insert at the "wrap-around" point (new max or new min)
            # e.g., ...4 -> 5 -> 1 -> 2...
            # If insertVal is 0 (new min) or 6 (new max)
            elif prev.val > curr.val:
                if insertVal >= prev.val or insertVal <= curr.val:
                    prev.next = new_node
                    new_node.next = curr
                    inserted = True
                    break

            # Move pointers to the next pair
            prev = curr
            curr = curr.next

            # If we've completed a full cycle and haven't inserted,
            # it means all elements in the list are the same.
            # In this case, we can insert anywhere, for example, after 'prev'.
            if prev == head:
                break

        # If insertion did not occur in the loop (e.g., all elements were identical),
        # insert the new node between prev and curr (which are head and head.next at this point)
        if not inserted:
            prev.next = new_node
            new_node.next = curr

        return head
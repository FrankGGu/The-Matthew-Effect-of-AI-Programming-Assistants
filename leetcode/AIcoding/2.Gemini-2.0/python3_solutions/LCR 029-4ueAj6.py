class Solution:
    def insert(self, head: 'Node', insertVal: int) -> 'Node':
        if not head:
            new_node = Node(insertVal)
            new_node.next = new_node
            return new_node

        curr = head
        while True:
            if curr.val <= insertVal <= curr.next.val:
                break
            if curr.val > curr.next.val:
                if insertVal >= curr.val or insertVal <= curr.next.val:
                    break
            curr = curr.next
            if curr == head:
                break

        new_node = Node(insertVal)
        new_node.next = curr.next
        curr.next = new_node
        return head
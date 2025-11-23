class Solution:
    def nextLargerNodes(self, head: Optional[ListNode]) -> List[int]:
        stack = []
        res = []
        index = 0
        current = head

        while current:
            res.append(0)
            current = current.next

        current = head
        positions = []
        pos = 0

        while current:
            while stack and stack[-1][1] < current.val:
                idx, val = stack.pop()
                res[idx] = current.val
            stack.append((pos, current.val))
            pos += 1
            current = current.next

        return res
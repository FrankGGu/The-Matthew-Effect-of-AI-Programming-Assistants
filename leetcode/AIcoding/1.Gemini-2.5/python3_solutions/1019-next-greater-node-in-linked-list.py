class Solution:
    def nextLargerNodes(self, head: ListNode) -> List[int]:
        values = []
        current = head
        while current:
            values.append(current.val)
            current = current.next

        n = len(values)
        ans = [0] * n
        stack = [] 

        for i in range(n):
            current_value = values[i]

            while stack and stack[-1][1] < current_value:
                prev_index, _ = stack.pop()
                ans[prev_index] = current_value

            stack.append((i, current_value))

        return ans
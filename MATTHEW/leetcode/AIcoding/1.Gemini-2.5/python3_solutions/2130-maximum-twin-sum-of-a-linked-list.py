class Solution:
    def pairSum(self, head: Optional[ListNode]) -> int:
        values = []
        current = head
        while current:
            values.append(current.val)
            current = current.next

        n = len(values)
        max_twin_sum = 0
        for i in range(n // 2):
            max_twin_sum = max(max_twin_sum, values[i] + values[n - 1 - i])

        return max_twin_sum
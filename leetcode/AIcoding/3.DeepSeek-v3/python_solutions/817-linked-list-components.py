class Solution:
    def numComponents(self, head: ListNode, nums: List[int]) -> int:
        num_set = set(nums)
        current = head
        components = 0
        in_component = False

        while current:
            if current.val in num_set:
                if not in_component:
                    components += 1
                    in_component = True
            else:
                in_component = False
            current = current.next

        return components
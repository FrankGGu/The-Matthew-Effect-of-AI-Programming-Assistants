class Solution:
    def verifyPostorder(self, postorder: List[int]) -> bool:
        def helper(start, end):
            if start >= end:
                return True
            root_val = postorder[end]
            i = start
            while i < end and postorder[i] < root_val:
                i += 1
            mid = i
            while i < end:
                if postorder[i] < root_val:
                    return False
                i += 1
            return helper(start, mid - 1) and helper(mid, end - 1)

        return helper(0, len(postorder) - 1)
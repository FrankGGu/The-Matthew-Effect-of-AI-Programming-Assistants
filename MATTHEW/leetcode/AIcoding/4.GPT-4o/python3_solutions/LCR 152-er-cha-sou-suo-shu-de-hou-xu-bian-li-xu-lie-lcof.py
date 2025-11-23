class Solution:
    def verifyPostorder(self, postorder: List[int]) -> bool:
        def helper(start, end):
            if start >= end:
                return True
            root = postorder[end]
            left_end = start - 1
            for i in range(start, end):
                if postorder[i] < root:
                    left_end += 1
                else:
                    break
            for j in range(left_end + 1, end):
                if postorder[j] < root:
                    return False
            return helper(start, left_end) and helper(left_end + 1, end - 1)

        return helper(0, len(postorder) - 1)
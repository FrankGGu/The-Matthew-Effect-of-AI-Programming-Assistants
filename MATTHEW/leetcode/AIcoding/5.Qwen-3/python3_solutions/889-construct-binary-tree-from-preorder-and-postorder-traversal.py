class Solution:
    def constructFromPrePost(self, pre: List[int], post: List[int]) -> TreeNode:
        if not pre:
            return None
        root = TreeNode(pre[0])
        if len(pre) == 1:
            return root
        i = post.index(pre[1])
        root.left = self.constructFromPrePost(pre[1:i+2], post[:i+1])
        root.right = self.constructFromPrePost(pre[i+2:], post[i+1:-1])
        return root
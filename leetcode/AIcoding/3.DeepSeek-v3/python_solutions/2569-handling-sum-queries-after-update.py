class SegmentTreeNode:
    __slots__ = ['l', 'r', 'left', 'right', 'sum_val', 'lazy']
    def __init__(self, l, r):
        self.l = l
        self.r = r
        self.left = None
        self.right = None
        self.sum_val = 0
        self.lazy = False

class SegmentTree:
    def __init__(self, nums):
        self.n = len(nums)
        self.root = self.build(0, self.n - 1, nums)

    def build(self, l, r, nums):
        node = SegmentTreeNode(l, r)
        if l == r:
            node.sum_val = nums[l]
            return node
        mid = (l + r) // 2
        node.left = self.build(l, mid, nums)
        node.right = self.build(mid + 1, r, nums)
        node.sum_val = node.left.sum_val + node.right.sum_val
        return node

    def push_down(self, node):
        if node.lazy:
            node.lazy = False
            if node.left:
                node.left.lazy = not node.left.lazy
                node.left.sum_val = (node.left.r - node.left.l + 1) - node.left.sum_val
            if node.right:
                node.right.lazy = not node.right.lazy
                node.right.sum_val = (node.right.r - node.right.l + 1) - node.right.sum_val

    def update_range(self, node, l, r):
        if node.r < l or node.l > r:
            return
        if l <= node.l and node.r <= r:
            node.sum_val = (node.r - node.l + 1) - node.sum_val
            node.lazy = not node.lazy
            return
        self.push_down(node)
        self.update_range(node.left, l, r)
        self.update_range(node.right, l, r)
        node.sum_val = node.left.sum_val + node.right.sum_val

    def query_sum(self, node, l, r):
        if node.r < l or node.l > r:
            return 0
        if l <= node.l and node.r <= r:
            return node.sum_val
        self.push_down(node)
        return self.query_sum(node.left, l, r) + self.query_sum(node.right, l, r)

class Solution:
    def handleQuery(self, nums1: List[int], nums2: List[int], queries: List[List[int]]) -> List[int]:
        st = SegmentTree(nums1)
        total = sum(nums2)
        res = []
        for query in queries:
            if query[0] == 1:
                l, r = query[1], query[2]
                st.update_range(st.root, l, r)
            elif query[0] == 2:
                p = query[1]
                cnt = st.query_sum(st.root, 0, len(nums1) - 1)
                total += p * cnt
            elif query[0] == 3:
                res.append(total)
        return res
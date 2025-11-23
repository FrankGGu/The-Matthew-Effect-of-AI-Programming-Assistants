class Solution:
    def longestRepeating(self, s: str, queryCharacters: str, queryIndices: List[int]) -> List[int]:
        n = len(s)
        q = len(queryIndices)
        s = list(s)
        res = []

        class SegmentTreeNode:
            __slots__ = ['left', 'right', 'l', 'r', 'left_char', 'right_char', 'max_len', 'prefix_len', 'suffix_len']
            def __init__(self, l, r):
                self.l = l
                self.r = r
                self.left = None
                self.right = None
                self.left_char = None
                self.right_char = None
                self.max_len = 0
                self.prefix_len = 0
                self.suffix_len = 0

        def build(l, r):
            node = SegmentTreeNode(l, r)
            if l == r:
                node.left_char = node.right_char = s[l]
                node.max_len = node.prefix_len = node.suffix_len = 1
            else:
                mid = (l + r) // 2
                node.left = build(l, mid)
                node.right = build(mid + 1, r)
                push_up(node)
            return node

        def push_up(node):
            left = node.left
            right = node.right
            node.left_char = left.left_char
            node.right_char = right.right_char
            node.max_len = max(left.max_len, right.max_len)
            if left.right_char == right.left_char:
                node.max_len = max(node.max_len, left.suffix_len + right.prefix_len)

            node.prefix_len = left.prefix_len
            if left.prefix_len == (left.r - left.l + 1) and left.right_char == right.left_char:
                node.prefix_len += right.prefix_len

            node.suffix_len = right.suffix_len
            if right.suffix_len == (right.r - right.l + 1) and left.right_char == right.left_char:
                node.suffix_len += left.suffix_len

        def update_pos(node, pos, char):
            if node.l == node.r:
                node.left_char = node.right_char = char
                return
            if pos <= node.left.r:
                update_pos(node.left, pos, char)
            else:
                update_pos(node.right, pos, char)
            push_up(node)

        root = build(0, n - 1)

        for i in range(q):
            pos = queryIndices[i]
            char = queryCharacters[i]
            if s[pos] != char:
                s[pos] = char
                update_pos(root, pos, char)
            res.append(root.max_len)

        return res
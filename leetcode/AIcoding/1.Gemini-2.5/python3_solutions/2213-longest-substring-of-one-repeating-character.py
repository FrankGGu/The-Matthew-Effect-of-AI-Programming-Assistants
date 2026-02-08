class Node:
    def __init__(self, l_char='', r_char='', l_len=0, r_len=0, max_len=0, total_len=0):
        self.l_char = l_char
        self.r_char = r_char
        self.l_len = l_len
        self.r_len = r_len
        self.max_len = max_len
        self.total_len = total_len

class SegmentTree:
    def __init__(self, s):
        self.n = len(s)
        self.tree = [None] * (4 * self.n)
        self.s_list = list(s)
        self._build(1, 0, self.n - 1)

    def _build(self, idx, start, end):
        if start == end:
            char = self.s_list[start]
            self.tree[idx] = Node(char, char, 1, 1, 1, 1)
        else:
            mid = (start + end) // 2
            self._build(2 * idx, start, mid)
            self._build(2 * idx + 1, mid + 1, end)
            self.tree[idx] = self._merge(self.tree[2 * idx], self.tree[2 * idx + 1])

    def _merge(self, left_node, right_node):
        if not left_node: return right_node
        if not right_node: return left_node

        new_node = Node()
        new_node.l_char = left_node.l_char
        new_node.r_char = right_node.r_char
        new_node.total_len = left_node.total_len + right_node.total_len

        new_node.l_len = left_node.l_len
        if left_node.l_len == left_node.total_len and left_node.r_char == right_node.l_char:
            new_node.l_len += right_node.l_len

        new_node.r_len = right_node.r_len
        if right_node.r_len == right_node.total_len and right_node.l_char == left_node.r_char:
            new_node.r_len += left_node.r_len

        new_node.max_len = max(left_node.max_len, right_node.max_len)
        if left_node.r_char == right_node.l_char:
            new_node.max_len = max(new_node.max_len, left_node.r_len + right_node.l_len)

        return new_node

    def update(self, pos, char):
        self.s_list[pos] = char
        self._update(1, 0, self.n - 1, pos, char)

    def _update(self, idx, start, end, pos, char):
        if start == end:
            self.tree[idx] = Node(char, char, 1, 1, 1, 1)
        else:
            mid = (start + end) // 2
            if start <= pos <= mid:
                self._update(2 * idx, start, mid, pos, char)
            else:
                self._update(2 * idx + 1, mid + 1, end, pos, char)
            self.tree[idx] = self._merge(self.tree[2 * idx], self.tree[2 * idx + 1])

    def query_max_len(self):
        return self.tree[1].max_len

class Solution:
    def longestRepeatingSubstring(self, s: str, queryCharacters: str, queryIndices: list[int]) -> list[int]:
        seg_tree = SegmentTree(s)

        results = []
        for i in range(len(queryCharacters)):
            char = queryCharacters[i]
            pos = queryIndices[i]
            seg_tree.update(pos, char)
            results.append(seg_tree.query_max_len())

        return results
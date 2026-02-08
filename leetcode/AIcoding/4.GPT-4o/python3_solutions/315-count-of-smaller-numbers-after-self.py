class SegmentTree:
    def __init__(self, n):
        self.n = n
        self.tree = [0] * (2 * n)

    def update(self, idx):
        idx += self.n
        while idx > 0:
            self.tree[idx] += 1
            idx //= 2

    def query(self, idx):
        idx += self.n
        count = 0
        while idx > 0:
            count += self.tree[idx]
            idx //= 2
        return count

class Solution:
    def countSmaller(self, nums: List[int]) -> List[int]:
        sorted_nums = sorted(set(nums))
        rank = {num: i for i, num in enumerate(sorted_nums)}
        st = SegmentTree(len(sorted_nums))
        result = []

        for num in reversed(nums):
            idx = rank[num]
            result.append(st.query(idx - 1))
            st.update(idx)

        return result[::-1]
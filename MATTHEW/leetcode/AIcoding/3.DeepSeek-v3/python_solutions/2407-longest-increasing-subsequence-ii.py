class SegmentTree:
    def __init__(self, size):
        self.size = size
        self.tree = [0] * (2 * self.size)

    def update(self, index, value):
        index += self.size
        self.tree[index] = value
        index >>= 1
        while index >= 1:
            self.tree[index] = max(self.tree[2 * index], self.tree[2 * index + 1])
            index >>= 1

    def query(self, l, r):
        res = 0
        l += self.size
        r += self.size
        while l <= r:
            if l % 2 == 1:
                res = max(res, self.tree[l])
                l += 1
            if r % 2 == 0:
                res = max(res, self.tree[r])
                r -= 1
            l >>= 1
            r >>= 1
        return res

class Solution:
    def lengthOfLIS(self, nums: List[int], k: int) -> int:
        max_num = max(nums)
        st = SegmentTree(max_num)
        res = 0
        for num in nums:
            l = max(1, num - k)
            r = num - 1
            curr = 1
            if l <= r:
                curr = st.query(l, r) + 1
            if curr > st.tree[num + st.size]:
                st.update(num, curr)
                res = max(res, curr)
        return res
class Solution:
    def goodTriplets(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        pos = [0] * n
        for i, num in enumerate(nums2):
            pos[num] = i

        pos_in_nums2 = [0] * n
        for i in range(n):
            pos_in_nums2[i] = pos[nums1[i]]

        class FenwickTree:
            def __init__(self, size):
                self.size = size
                self.tree = [0] * (self.size + 1)

            def update(self, index, delta=1):
                while index <= self.size:
                    self.tree[index] += delta
                    index += index & -index

            def query(self, index):
                res = 0
                while index > 0:
                    res += self.tree[index]
                    index -= index & -index
                return res

        ft = FenwickTree(n)
        left = [0] * n
        for i in range(n):
            left[i] = ft.query(pos_in_nums2[i])
            ft.update(pos_in_nums2[i] + 1)

        ft = FenwickTree(n)
        right = [0] * n
        for i in range(n-1, -1, -1):
            right[i] = ft.query(n) - ft.query(pos_in_nums2[i] + 1)
            ft.update(pos_in_nums2[i] + 1)

        res = 0
        for i in range(n):
            res += left[i] * right[i]
        return res
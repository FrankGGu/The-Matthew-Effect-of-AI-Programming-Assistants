class BookMyShow:

    def __init__(self, n: int, m: int):
        self.n = n
        self.m = m
        self.min_tree = [0] * (4 * n)
        self.sum_tree = [0] * (4 * n)
        self.build(0, 0, n - 1)

    def build(self, node, l, r):
        if l == r:
            self.min_tree[node] = self.m
            self.sum_tree[node] = self.m
            return
        mid = (l + r) // 2
        self.build(2 * node + 1, l, mid)
        self.build(2 * node + 2, mid + 1, r)
        self.min_tree[node] = min(self.min_tree[2 * node + 1], self.min_tree[2 * node + 2])
        self.sum_tree[node] = self.sum_tree[2 * node + 1] + self.sum_tree[2 * node + 2]

    def update_min(self, node, l, r, idx, val):
        if l == r:
            self.min_tree[node] = val
            self.sum_tree[node] = val
            return
        mid = (l + r) // 2
        if idx <= mid:
            self.update_min(2 * node + 1, l, mid, idx, val)
        else:
            self.update_min(2 * node + 2, mid + 1, r, idx, val)
        self.min_tree[node] = min(self.min_tree[2 * node + 1], self.min_tree[2 * node + 2])
        self.sum_tree[node] = self.sum_tree[2 * node + 1] + self.sum_tree[2 * node + 2]

    def query_min(self, node, l, r, L, R):
        if R < l or L > r:
            return float('inf')
        if L <= l and r <= R:
            return self.min_tree[node]
        mid = (l + r) // 2
        left = self.query_min(2 * node + 1, l, mid, L, R)
        right = self.query_min(2 * node + 2, mid + 1, r, L, R)
        return min(left, right)

    def query_sum(self, node, l, r, L, R):
        if R < l or L > r:
            return 0
        if L <= l and r <= R:
            return self.sum_tree[node]
        mid = (l + r) // 2
        left = self.query_sum(2 * node + 1, l, mid, L, R)
        right = self.query_sum(2 * node + 2, mid + 1, r, L, R)
        return left + right

    def gather(self, k: int, max_row: int) -> List[int]:
        low = 0
        high = max_row
        res = -1
        while low <= high:
            mid = (low + high) // 2
            min_seats = self.query_min(0, 0, self.n - 1, 0, mid)
            if min_seats >= k:
                res = mid
                high = mid - 1
            else:
                low = mid + 1
        if res == -1:
            return []
        seats = self.query_sum(0, 0, self.n - 1, res, res)
        self.update_min(0, 0, self.n - 1, res, seats - k)
        return [res, self.m - seats]

    def scatter(self, k: int, max_row: int) -> bool:
        total = self.query_sum(0, 0, self.n - 1, 0, max_row)
        if total < k:
            return False
        i = 0
        while k > 0:
            seats = self.query_sum(0, 0, self.n - 1, i, i)
            take = min(seats, k)
            self.update_min(0, 0, self.n - 1, i, seats - take)
            k -= take
            i += 1
        return True
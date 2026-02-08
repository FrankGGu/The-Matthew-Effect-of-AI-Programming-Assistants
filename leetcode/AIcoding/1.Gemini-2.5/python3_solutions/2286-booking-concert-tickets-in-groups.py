class SegmentTree:
    def __init__(self, n, m):
        self.n = n
        self.m = m
        self.tree = [None] * (4 * n) 
        self._build(1, 0, n - 1)

    def _build(self, node_idx, start, end):
        if start == end:
            self.tree[node_idx] = {'max_seats': self.m, 'total_seats': self.m, 'first_avail_row': start}
        else:
            mid = (start + end) // 2
            self._build(2 * node_idx, start, mid)
            self._build(2 * node_idx + 1, mid + 1, end)
            self.tree[node_idx] = self._merge(self.tree[2 * node_idx], self.tree[2 * node_idx + 1])

    def _merge(self, left_node_val, right_node_val):
        max_s = max(left_node_val['max_seats'], right_node_val['max_seats'])
        total_s = left_node_val['total_seats'] + right_node_val['total_seats']
        first_avail = left_node_val['first_avail_row'] if left_node_val['first_avail_row'] != self.n else right_node_val['first_avail_row']
        return {'max_seats': max_s, 'total_seats': total_s, 'first_avail_row': first_avail}

    def update(self, node_idx, start, end, row_idx, new_seats_val):
        if start == end:
            self.tree[node_idx]['max_seats'] = new_seats_val
            self.tree[node_idx]['total_seats'] = new_seats_val
            self.tree[node_idx]['first_avail_row'] = row_idx if new_seats_val > 0 else self.n
            return

        mid = (start + end) // 2
        if row_idx <= mid:
            self.update(2 * node_idx, start, mid, row_idx, new_seats_val)
        else:
            self.update(2 * node_idx + 1, mid + 1, end, row_idx, new_seats_val)

        self.tree[node_idx] = self._merge(self.tree[2 * node_idx], self.tree[2 * node_idx + 1])

    def query_first_row_with_k_seats(self, node_idx, start, end, k, max_query_row):
        if start > max_query_row or self.tree[node_idx]['max_seats'] < k:
            return self.n

        if start == end:
            return start

        mid = (start + end) // 2

        res = self.query_first_row_with_k_seats(2 * node_idx, start, mid, k, max_query_row)
        if res != self.n:
            return res

        return self.query_first_row_with_k_seats(2 * node_idx + 1, mid + 1, end, k, max_query_row)

    def query_total_seats(self, node_idx, start, end, query_start, query_end):
        if start > query_end or end < query_start:
            return 0

        if query_start <= start and end <= query_end:
            return self.tree[node_idx]['total_seats']

        mid = (start + end) // 2
        left_sum = self.query_total_seats(2 * node_idx, start, mid, query_start, query_end)
        right_sum = self.query_total_seats(2 * node_idx + 1, mid + 1, end, query_start, query_end)
        return left_sum + right_sum

    def query_first_avail_row_in_range(self, node_idx, start, end, query_start, query_end):
        if start > query_end or end < query_start or self.tree[node_idx]['first_avail_row'] == self.n:
            return self.n

        if start == end:
            return start

        mid = (start + end) // 2

        res = self.query_first_avail_row_in_range(2 * node_idx, start, mid, query_start, query_end)
        if res != self.n:
            return res

        return self.query_first_avail_row_in_range(2 * node_idx + 1, mid + 1, end, query_start, query_end)

class ConcertTracker:
    def __init__(self, n: int, m: int):
        self.n = n
        self.m = m
        self.rows_available_seats = [m] * n
        self.seg_tree = SegmentTree(n, m)

    def book(self, k: int) -> list[int]:
        row_idx = self.seg_tree.query_first_row_with_k_seats(1, 0, self.n - 1, k, self.n - 1)

        if row_idx == self.n:
            return []

        start_seat_idx = self.m - self.rows_available_seats[row_idx]

        self.rows_available_seats[row_idx] -= k

        self.seg_tree.update(1, 0, self.n - 1, row_idx, self.rows_available_seats[row_idx])

        return [row_idx, start_seat_idx]

    def scatter(self, k: int, max_row: int) -> bool:
        total_possible_seats = self.seg_tree.query_total_seats(1, 0, self.n - 1, 0, max_row)

        if total_possible_seats < k:
            return False

        current_k_to_fill = k
        current_row_search_start = 0

        while current_k_to_fill > 0:
            row_idx = self.seg_tree.query_first_avail_row_in_range(1, 0, self.n - 1, current_row_search_start, max_row)

            if row_idx == self.n:
                break 

            seats_in_this_row = self.rows_available_seats[row_idx]
            seats_to_book_in_this_row = min(current_k_to_fill, seats_in_this_row)

            self.rows_available_seats[row_idx] -= seats_to_book_in_this_row
            current_k_to_fill -= seats_to_book_in_this_row

            self.seg_tree.update(1, 0, self.n - 1, row_idx, self.rows_available_seats[row_idx])

            current_row_search_start = row_idx + 1

        return True
import bisect

class Solution:
    def mostBeautifulItem(self, items: list[list[int]], queries: list[list[int]]) -> list[int]:
        all_beauties = sorted(list(set([item[1] for item in items])))

        beauty_to_idx = {b: i + 1 for i, b in enumerate(all_beauties)}
        K = len(all_beauties)

        bit = [0] * (K + 1)

        def update_bit(idx, val):
            while idx <= K:
                bit[idx] = max(bit[idx], val)
                idx += idx & (-idx)

        def query_bit(idx):
            res = 0
            while idx > 0:
                res = max(res, bit[idx])
                idx -= idx & (-idx)
            return res

        items.sort()

        queries_with_indices = []
        for i, q in enumerate(queries):
            queries_with_indices.append((q[0], q[1], i))
        queries_with_indices.sort()

        answers = [0] * len(queries)
        item_ptr = 0

        for price_limit, beauty_limit, original_idx in queries_with_indices:
            while item_ptr < len(items) and items[item_ptr][0] <= price_limit:
                item_beauty = items[item_ptr][1]
                item_beauty_idx = beauty_to_idx[item_beauty]
                update_bit(item_beauty_idx, item_beauty)
                item_ptr += 1

            query_beauty_idx = bisect.bisect_right(all_beauties, beauty_limit)

            if query_beauty_idx > 0:
                answers[original_idx] = query_bit(query_beauty_idx)
            else:
                answers[original_idx] = 0

        return answers
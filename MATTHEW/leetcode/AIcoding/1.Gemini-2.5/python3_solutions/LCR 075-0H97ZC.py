import collections

class Solution:
    def relativeSortArray(self, arr1: list[int], arr2: list[int]) -> list[int]:
        order_map = {val: i for i, val in enumerate(arr2)}

        def custom_key(x):
            if x in order_map:
                # Elements present in arr2 are sorted by their index in arr2.
                # The second element 'x' is for stable sorting within the same group,
                # though for this problem, the primary key (order_map[x]) is sufficient
                # to determine the relative order of distinct values from arr2.
                return (order_map[x], x)
            else:
                # Elements not in arr2 should appear at the end, sorted in ascending order.
                # We use a primary key (len(arr2)) that is guaranteed to be larger
                # than any index in order_map, ensuring these elements come last.
                # The secondary key 'x' sorts these remaining elements by their value.
                return (len(arr2), x)

        arr1.sort(key=custom_key)

        return arr1
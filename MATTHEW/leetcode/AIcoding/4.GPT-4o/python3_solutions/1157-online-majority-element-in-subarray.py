class MajorityChecker:

    def __init__(self, arr: List[int]):
        self.arr = arr
        self.index_map = defaultdict(list)
        for i, num in enumerate(arr):
            self.index_map[num].append(i)

    def query(self, left: int, right: int, threshold: int) -> int:
        candidates = []
        for num in self.index_map:
            if self.index_map[num][0] <= right and self.index_map[num][-1] >= left:
                candidates.append(num)

        for candidate in candidates:
            left_index = bisect.bisect_left(self.index_map[candidate], left)
            right_index = bisect.bisect_right(self.index_map[candidate], right)
            count = right_index - left_index
            if count >= threshold:
                return candidate

        return -1
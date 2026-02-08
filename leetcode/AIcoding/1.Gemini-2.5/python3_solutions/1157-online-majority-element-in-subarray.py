import collections
import random
import bisect

class MajorityChecker:

    def __init__(self, arr: list[int]):
        self.arr = arr
        self.indices = collections.defaultdict(list)
        for i, num in enumerate(arr):
            self.indices[num].append(i)

    def query(self, left: int, right: int, threshold: int) -> int:
        num_samples = 20 

        for _ in range(num_samples):
            random_idx = random.randint(left, right)
            candidate_val = self.arr[random_idx]

            candidate_indices = self.indices[candidate_val]

            count = bisect.bisect_right(candidate_indices, right) - \
                    bisect.bisect_left(candidate_indices, left)

            if count >= threshold:
                return candidate_val

        return -1
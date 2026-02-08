class Solution:
    def closestEqualElements(self, arr: List[int], queries: List[List[int]]) -> List[int]:
        indices = defaultdict(list)
        for i, num in enumerate(arr):
            indices[num].append(i)

        result = []
        for left, right in queries:
            best_dist = float('inf')

            for num, idx_list in indices.items():

                l = bisect_left(idx_list, left)
                r = bisect_right(idx_list, right)

                for i in range(max(0, l - 2), min(r + 2, len(idx_list))):
                    idx = idx_list[i]
                    if left <= idx <= right:

                        for j in range(i + 1, min(r + 2, len(idx_list))):
                            idx2 = idx_list[j]
                            if left <= idx2 <= right:
                                best_dist = min(best_dist, abs(idx - idx2))

                        for j in range(max(0, l - 2), i):
                            idx2 = idx_list[j]
                            if left <= idx2 <= right:
                                best_dist = min(best_dist, abs(idx - idx2))

            if best_dist == float('inf'):
                result.append(-1)
            else:
                result.append(best_dist)

        return result
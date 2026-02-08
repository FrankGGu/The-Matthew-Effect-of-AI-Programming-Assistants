import math
from bisect import bisect_right

class Solution:
    def minSpaceWasted(self, packages: list[int], suppliers: list[list[int]]) -> int:
        MOD = 10**9 + 7

        packages.sort()
        N = len(packages)

        prefix_sums = [0] * (N + 1)
        for i in range(N):
            prefix_sums[i+1] = prefix_sums[i] + packages[i]

        min_total_waste = math.inf

        for supplier_boxes in suppliers:
            supplier_boxes.sort()

            current_supplier_waste = 0
            last_package_idx_covered = -1 

            for box_size in supplier_boxes:
                idx_after_covered = bisect_right(packages, box_size)

                start_idx = last_package_idx_covered + 1
                end_idx = idx_after_covered

                if start_idx < end_idx:
                    count = end_idx - start_idx
                    sum_of_covered_packages = prefix_sums[end_idx] - prefix_sums[start_idx]
                    current_supplier_waste += (count * box_size - sum_of_covered_packages)
                    last_package_idx_covered = end_idx - 1

                if last_package_idx_covered == N - 1:
                    break

            if last_package_idx_covered == N - 1:
                min_total_waste = min(min_total_waste, current_supplier_waste)

        if min_total_waste == math.inf:
            return -1
        else:
            return int(min_total_waste % MOD)
def minWastedSpace(packages: list[int], boxes: list[list[int]]) -> int:
    packages.sort()
    MOD = 10**9 + 7
    min_waste = float('inf')

    for box_sizes in boxes:
        box_sizes.sort()
        if box_sizes[-1] < packages[-1]:
            continue

        waste = 0
        prev = 0
        for size in packages:
            l, r = 0, len(box_sizes) - 1
            idx = -1
            while l <= r:
                mid = (l + r) // 2
                if box_sizes[mid] >= size:
                    idx = mid
                    r = mid - 1
                else:
                    l = mid + 1

            waste += box_sizes[idx]

        prefix_sum = [0] * (len(packages) + 1)
        for i in range(len(packages)):
            prefix_sum[i+1] = prefix_sum[i] + packages[i]

        total_package_size = prefix_sum[-1]

        min_waste = min(min_waste, waste * len(packages) // len(packages) - total_package_size)

    if min_waste == float('inf'):
        return -1
    else:
        return min_waste % MOD
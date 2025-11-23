def maxTotalFruits(fruits, startPos, k):
    n = len(fruits)
    prefix_sum = [0] * (n + 1)
    for i in range(n):
        prefix_sum[i + 1] = prefix_sum[i] + fruits[i][1]

    def get_sum(l, r):
        return prefix_sum[r + 1] - prefix_sum[l]

    max_fruits = 0
    for x in range(n):
        for y in range(n):
            left = min(fruits[x][0], fruits[y][0])
            right = max(fruits[x][0], fruits[y][0])
            distance = abs(fruits[x][0] - startPos) + abs(fruits[y][0] - startPos) + (right - left)
            if distance <= k:

                left_index = -1
                right_index = -1

                l = 0
                r = n - 1

                while l <= r:
                    mid = (l+r) // 2
                    if fruits[mid][0] >= left:
                        left_index = mid
                        r = mid - 1
                    else:
                        l = mid + 1

                l = 0
                r = n - 1

                while l <= r:
                    mid = (l+r) // 2
                    if fruits[mid][0] <= right:
                        right_index = mid
                        l = mid + 1
                    else:
                        r = mid - 1

                if left_index != -1 and right_index != -1:
                    max_fruits = max(max_fruits, get_sum(left_index, right_index))

    for i in range(n):
        if abs(fruits[i][0] - startPos) <= k:
            left_steps = abs(fruits[i][0] - startPos)
            remaining_steps = k - left_steps

            left_bound = min(fruits[i][0], startPos) - remaining_steps
            right_bound = max(fruits[i][0], startPos) + remaining_steps

            left_index = -1
            right_index = -1

            l = 0
            r = n - 1

            while l <= r:
                mid = (l+r) // 2
                if fruits[mid][0] >= left_bound:
                    left_index = mid
                    r = mid - 1
                else:
                    l = mid + 1

            l = 0
            r = n - 1

            while l <= r:
                mid = (l+r) // 2
                if fruits[mid][0] <= right_bound:
                    right_index = mid
                    l = mid + 1
                else:
                    r = mid - 1

            if left_index != -1 and right_index != -1:
                max_fruits = max(max_fruits, get_sum(left_index, right_index))

    return max_fruits
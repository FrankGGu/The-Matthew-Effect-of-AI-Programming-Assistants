from collections import defaultdict

def shortestSupersequence(nums, queries):
    n = len(nums)
    q_len = len(queries)
    ans = [0] * q_len

    for i in range(q_len):
        q = queries[i]
        q_len_i = len(q)

        first_occurrences = defaultdict(list)
        for j in range(q_len_i):
            num = q[j]
            for k in range(n):
                if nums[k] == num:
                    first_occurrences[j].append(k)

        if any(not first_occurrences[j] for j in range(q_len_i)):
            ans[i] = 0
            continue

        intervals = []

        def generate_intervals(index, current_interval):
            if index == q_len_i:
                intervals.append(current_interval)
                return

            for pos in first_occurrences[index]:
                generate_intervals(index + 1, current_interval + [pos])

        generate_intervals(0, [])

        min_len = float('inf')
        count = 0

        for interval in intervals:
            interval_len = max(interval) - min(interval) + 1
            if interval_len < min_len:
                min_len = interval_len
                count = 1
            elif interval_len == min_len:
                count += 1

        ans[i] = count

    return ans
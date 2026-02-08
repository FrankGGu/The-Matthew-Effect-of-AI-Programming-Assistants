def max_cost_substring(s: str, chars: str, vals: list[int]) -> int:
    cost = {}
    for i in range(len(chars)):
        cost[chars[i]] = vals[i]

    max_so_far = 0
    current_max = 0

    for char in s:
        val = cost.get(char, ord(char) - ord('a') + 1)
        current_max += val
        if current_max < 0:
            current_max = 0
        max_so_far = max(max_so_far, current_max)

    return max_so_far
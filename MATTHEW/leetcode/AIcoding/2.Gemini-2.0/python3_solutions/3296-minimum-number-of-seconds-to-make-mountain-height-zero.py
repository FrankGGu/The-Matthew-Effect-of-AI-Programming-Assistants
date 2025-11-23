def minimumSeconds(nums: list[int]) -> int:
    first_occurrence = {}
    last_occurrence = {}
    for i, num in enumerate(nums):
        if num not in first_occurrence:
            first_occurrence[num] = i
        last_occurrence[num] = i

    n = len(nums)
    max_reach = {}
    for num in first_occurrence:
        first = first_occurrence[num]
        last = last_occurrence[num]

        distance = (last - first + 1) // 2
        if last < first:
            distance = (last + n - first + 1) // 2

        max_reach[num] = distance

    return max(max_reach.values())
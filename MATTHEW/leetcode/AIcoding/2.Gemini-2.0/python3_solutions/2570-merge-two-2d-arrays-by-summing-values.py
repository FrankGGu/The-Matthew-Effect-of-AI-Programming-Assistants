def mergeArrays(nums1: list[list[int]], nums2: list[list[int]]) -> list[list[int]]:
    result = {}
    for id, val in nums1:
        result[id] = result.get(id, 0) + val
    for id, val in nums2:
        result[id] = result.get(id, 0) + val

    sorted_result = sorted(result.items())
    return [[id, val] for id, val in sorted_result]
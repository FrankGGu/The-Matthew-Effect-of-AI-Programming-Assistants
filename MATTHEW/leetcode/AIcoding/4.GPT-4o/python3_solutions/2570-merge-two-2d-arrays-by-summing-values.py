def mergeArrays(nums1, nums2):
    from collections import defaultdict
    result = defaultdict(int)

    for num in nums1:
        result[num[0]] += num[1]

    for num in nums2:
        result[num[0]] += num[1]

    return sorted(result.items())
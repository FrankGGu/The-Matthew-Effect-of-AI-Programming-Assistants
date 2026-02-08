def find_occurrences(arr: list[int], target: int) -> list[int]:
    """
    Given an array of integers arr and an integer target, return a list of the indices of the occurrences of target in arr.
    If target does not appear in arr, return an empty list.
    For example:
    find_occurrences([1, 2, 3, 2, 4, 2, 5], 2) == [1, 3, 5]
    find_occurrences([1, 2, 3, 4, 5], 6) == []
    """
    occurrences = []
    for i, num in enumerate(arr):
        if num == target:
            occurrences.append(i)
    return occurrences
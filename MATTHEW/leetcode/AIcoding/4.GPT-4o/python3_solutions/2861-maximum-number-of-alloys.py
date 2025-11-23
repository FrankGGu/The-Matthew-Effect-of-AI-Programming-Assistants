def maxAlloys(A: List[int], B: List[int], C: List[int], D: List[int]) -> int:
    from collections import defaultdict
    from itertools import product

    def generate_combinations(arr1, arr2):
        result = defaultdict(int)
        for a, b in product(arr1, arr2):
            result[a + b] += 1
        return result

    AB = generate_combinations(A, B)
    CD = generate_combinations(C, D)

    max_alloys = 0
    for value in AB:
        if value in CD:
            max_alloys = max(max_alloys, AB[value] + CD[value])

    return max_alloys
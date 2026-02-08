from collections import defaultdict

def findDiagonalOrder(nums):
    diagonal_map = defaultdict(list)
    max_diagonal = 0

    for i in range(len(nums)):
        for j in range(len(nums[i])):
            diagonal_map[i + j].append(nums[i][j])
            max_diagonal = max(max_diagonal, i + j)

    result = []
    for k in range(max_diagonal + 1):
        result.extend(reversed(diagonal_map[k]))

    return result
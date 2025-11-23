from collections import defaultdict

def mostCommonResponse(responses: list[list[int]]) -> list[int]:
    counts = defaultdict(int)
    for i in range(len(responses[0])):
        col = []
        for j in range(len(responses)):
            col.append(responses[j][i])

        col_str = tuple(col)
        counts[col_str] += 1

    max_count = 0
    result = []
    for col_str, count in counts.items():
        if count > max_count:
            max_count = count
            result = list(col_str)

    return result
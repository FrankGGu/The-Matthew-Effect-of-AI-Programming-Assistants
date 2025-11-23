def rowAndMaximumOnes(matrix):
    max_row_index = -1
    max_ones_count = -1

    for i in range(len(matrix)):
        ones_count = sum(matrix[i])
        if ones_count > max_ones_count:
            max_ones_count = ones_count
            max_row_index = i

    return [max_row_index, max_ones_count]
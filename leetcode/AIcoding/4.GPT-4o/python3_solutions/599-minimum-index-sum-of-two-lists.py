def findRestaurant(list1, list2):
    index_sum = {}
    for i, restaurant in enumerate(list1):
        index_sum[restaurant] = i

    min_sum = float('inf')
    result = []

    for j, restaurant in enumerate(list2):
        if restaurant in index_sum:
            total_index = j + index_sum[restaurant]
            if total_index < min_sum:
                min_sum = total_index
                result = [restaurant]
            elif total_index == min_sum:
                result.append(restaurant)

    return result
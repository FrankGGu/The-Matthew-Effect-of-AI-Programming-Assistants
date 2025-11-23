def findClosestPerson(friends: list[int], locations: list[list[int]], personIndex: int) -> int:
    min_distance = float('inf')
    closest_person = -1
    person_location = locations[personIndex]
    for i in range(len(friends)):
        if i == personIndex:
            continue
        friend_location = locations[i]
        distance = abs(friend_location[0] - person_location[0]) + abs(friend_location[1] - person_location[1])
        if distance < min_distance:
            min_distance = distance
            closest_person = friends[i]
        elif distance == min_distance and friends[i] < closest_person:
            closest_person = friends[i]
    return closest_person
def latestTimeCatchTheBus(buses: list[int], passengers: list[int], capacity: int) -> int:
    buses.sort()
    passengers.sort()

    j = 0
    count = 0

    for bus in buses:
        count = 0
        while j < len(passengers) and passengers[j] <= bus and count < capacity:
            j += 1
            count += 1

    if count < capacity:
        ans = buses[-1]
    else:
        ans = passengers[j-1]

    while ans in set(passengers):
        ans -= 1

    return ans
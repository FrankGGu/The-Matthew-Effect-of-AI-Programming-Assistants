def eliminateMaximum(dist: List[int], speed: List[int]) -> int:
    arrival_times = sorted(d / s for d, s in zip(dist, speed))
    for i in range(len(arrival_times)):
        if arrival_times[i] <= i:
            return i
    return len(arrival_times)
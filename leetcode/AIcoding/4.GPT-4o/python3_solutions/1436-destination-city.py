def destCity(paths):
    start_cities = set(start for start, end in paths)
    for start, end in paths:
        if end not in start_cities:
            return end